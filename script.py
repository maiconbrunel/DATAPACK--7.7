#!/usr/bin/env python3
# Extractor + Importer – Premium (Revised / Safe Multi-File Import + FolderName TXT Export)

import os
import json
import platform
import tkinter as tk
from tkinter import messagebox, filedialog

CONFIG_FILE = ".extractor_config.json"


# ============================================================
# HELPERS
# ============================================================

def path_norm(p):
    return os.path.abspath(str(p)).replace("\\", "/")


def path_shorten(p):
    p = str(p)
    return p if len(p) <= 70 else "..." + p[-70:]


def folder_open(path):
    try:
        path = path_norm(path)
        sys = platform.system().lower()
        if sys == "windows":
            os.startfile(path)
        elif sys == "darwin":
            os.system(f'open "{path}"')
        else:
            os.system(f'xdg-open "{path}"')
    except:
        pass


def filename_unique(name, directory):
    directory = path_norm(directory)
    full = os.path.join(directory, name)
    if not os.path.exists(full):
        return full

    base, ext = os.path.splitext(name)
    i = 1
    while True:
        n = os.path.join(directory, f"{base} ({i}){ext}")
        if not os.path.exists(n):
            return n
        i += 1


def errlog(msg):
    try:
        with open("errors.txt", "a", encoding="utf-8") as f:
            f.write(msg + "\n")
    except:
        pass


# ============================================================
# CONFIG
# ============================================================

def config_load():
    if os.path.exists(CONFIG_FILE):
        try:
            with open(CONFIG_FILE, "r", encoding="utf-8") as f:
                cfg = json.load(f)
            cfg["base_path"] = path_norm(cfg.get("base_path", os.getcwd()))
            cfg["last_export_path"] = path_norm(cfg.get("last_export_path", os.getcwd()))
            cfg["file_mode"] = cfg.get("file_mode", "both")
            return cfg
        except:
            pass

    base = filedialog.askdirectory(title="Selecione a Pasta Base (referência)")
    if not base:
        messagebox.showerror("Erro", "Nenhuma pasta base selecionada.")
        exit()

    cfg = {
        "base_path": path_norm(base),
        "last_export_path": path_norm(os.getcwd()),
        "file_mode": "both"
    }
    config_save(cfg)
    return cfg


def config_save(cfg):
    with open(CONFIG_FILE, "w", encoding="utf-8") as f:
        json.dump(cfg, f, indent=4)


# ============================================================
# SCAN ENGINE
# ============================================================

def scan_collect(scan_dir, recursive, mode):
    scan_dir = path_norm(scan_dir)
    lua, xml = [], []

    def add(fp, f):
        n = f.lower()
        if n.endswith(".lua") and mode in ("both", "lua"):
            lua.append(fp)
        elif n.endswith(".xml") and mode in ("both", "xml"):
            xml.append(fp)

    if recursive:
        for r, _, files in os.walk(scan_dir):
            for f in files:
                fp = path_norm(os.path.join(r, f))
                add(fp, f)
    else:
        for f in os.listdir(scan_dir):
            fp = path_norm(os.path.join(scan_dir, f))
            if os.path.isfile(fp):
                add(fp, f)

    return lua, xml


# ============================================================
# IMPORT ENGINE (REVISED + SAFE + MULTI-FILE)
# ============================================================

def import_engine():
    cfg = config_load()
    base = cfg["base_path"]

    txt_paths = filedialog.askopenfilenames(
        title="Selecione um ou mais arquivos TXT",
        filetypes=[("Arquivos TXT", "*.txt")]
    )
    if not txt_paths:
        return

    txt_paths = [path_norm(p) for p in txt_paths]

    mode_window = tk.Tk()
    mode_window.title("Modo de Importação")
    mode = tk.StringVar(value="auto")

    tk.Label(mode_window, text="Selecione o modo:", font=("Arial", 11)).pack(pady=10)
    for label, val in [
        ("Automático (ABSOLUTE_PATH)", "auto"),
        ("Manual (escolher pasta destino)", "manual"),
        ("Sandbox (pasta atual)", "sandbox")
    ]:
        tk.Radiobutton(mode_window, text=label, variable=mode, value=val).pack(anchor="w", padx=20)

    tk.Button(mode_window, text="OK", command=mode_window.destroy).pack(pady=10)
    mode_window.mainloop()
    mode = mode.get()

    manual = None
    if mode == "manual":
        manual = filedialog.askdirectory(title="Escolha pasta destino")
        if not manual:
            messagebox.showerror("Erro", "Nenhuma pasta selecionada.")
            return
        manual = path_norm(manual)

    all_blocks = []
    for txt in txt_paths:
        try:
            with open(txt, "r", encoding="utf-8") as f:
                data = f.read()
        except:
            errlog(f"[ERRO] Falha ao abrir TXT: {txt}")
            continue

        if "===== FILE_START:" not in data:
            errlog(f"[IGNORADO] Arquivo sem blocos: {txt}")
            continue

        raw_blocks = data.split("===== FILE_START: ")[1:]
        for b in raw_blocks:
            if (" =====" not in b or
                "#<ABSOLUTE_PATH>" not in b or
                "</ABSOLUTE_PATH>" not in b or
                "===== FILE_END" not in b):
                continue

            all_blocks.append(b)

    if not all_blocks:
        messagebox.showerror("Erro", "Nenhum bloco válido encontrado.")
        return

    used = set()
    ok = skip = fail = 0

    for block in all_blocks:
        try:
            rel, rest = block.split(" =====", 1)
            rel = rel.strip()

            if rel in used:
                skip += 1
                continue
            used.add(rel)

            abs_path = rest.split("#<ABSOLUTE_PATH>")[1].split("</ABSOLUTE_PATH>")[0].strip()
            abs_path = path_norm(abs_path)

            content = rest.split("</ABSOLUTE_PATH>")[1].split("===== FILE_END")[0].lstrip("\n")
            if not content.strip():
                skip += 1
                continue

            if mode == "auto":
                if not abs_path.startswith(base):
                    fail += 1
                    continue
                final = abs_path

            elif mode == "manual":
                final = path_norm(os.path.join(manual, rel))

            else:
                final = path_norm(os.path.join(os.getcwd(), rel))
                if not final.startswith(os.getcwd()):
                    fail += 1
                    continue

            os.makedirs(os.path.dirname(final), exist_ok=True)

            if os.path.exists(final):
                i = 1
                while True:
                    bak = f"{final}.bak{i}"
                    if not os.path.exists(bak):
                        break
                    i += 1
                try:
                    with open(final, "r", encoding="utf-8") as r:
                        old = r.read()
                    with open(bak, "w", encoding="utf-8") as w:
                        w.write(old)
                except:
                    errlog(f"[ERRO] Backup falhou: {final}")

            try:
                with open(final, "w", encoding="utf-8") as w:
                    w.write(content)
                ok += 1
            except Exception as e:
                errlog(f"[ERRO WRITE] {final}: {e}")
                fail += 1

        except Exception as e:
            errlog(f"[ERRO GLOBAL] {e}")
            fail += 1

    messagebox.showinfo(
        "Importação concluída",
        f"Reinseridos: {ok}\nPulados: {skip}\nErros: {fail}"
    )


# ============================================================
# EXPORT ENGINE (foldername.txt + multiparte)
# ============================================================

def export_engine(cfg, scan_path, export_path, recursive, limit, mode):
    lua, xml = scan_collect(scan_path, recursive, mode)
    selected = sorted(lua + xml)

    if not selected:
        messagebox.showerror("Erro", "Nenhum arquivo encontrado.")
        return

    folder_name = os.path.basename(path_norm(scan_path))
    if not folder_name:
        folder_name = "extracted"

    base_filename = folder_name.replace(" ", "_") + ".txt"

    total_size = 0
    part = 1
    count = 0

    out_file = filename_unique(base_filename, export_path)

    try:
        writer = open(out_file, "a", encoding="utf-8")
    except Exception as e:
        messagebox.showerror("Erro", f"Falha ao criar arquivo:\n{e}")
        return

    for fp in selected:
        try:
            with open(fp, "r", encoding="utf-8", errors="replace") as f:
                content = f.read()
        except Exception as e:
            errlog(f"Erro lendo {fp}: {e}")
            continue

        rel = os.path.relpath(fp, cfg["base_path"]).replace("\\", "/")
        abs_path = path_norm(fp)

        block = (
            f"===== FILE_START: {rel} =====\n"
            f"#<ABSOLUTE_PATH>{abs_path}</ABSOLUTE_PATH>\n"
            f"{content}\n"
            f"===== FILE_END =====\n\n"
        )

        total_size += len(block.encode("utf-8"))

        if count == limit:
            writer.close()
            part += 1
            part_name = folder_name.replace(" ", "_") + f"_part{part}.txt"
            out_file = filename_unique(part_name, export_path)
            writer = open(out_file, "a", encoding="utf-8")
            count = 0

        writer.write(block)
        count += 1

    writer.close()
    folder_open(export_path)

    messagebox.showinfo(
        "Extração concluída",
        f"Pasta: {export_path}\n"
        f"Arquivo base: {folder_name}.txt\n"
        f"Tamanho total: {total_size/1024:.2f} KB\n"
        f"Partes: {part}"
    )


# ============================================================
# GUI / MAIN
# ============================================================

def gui_main():
    cfg = config_load()

    root = tk.Tk()
    root.title("Extractor + Importador")

    status = tk.StringVar(value="Pronto.")
    tk.Label(root, textvariable=status, relief="sunken", anchor="w").pack(side="bottom", fill="x")

    tk.Label(root, text="Pasta Base:", font=("Arial", 10, "bold")).pack()
    lbl_base = tk.Label(root, text=path_shorten(cfg["base_path"]), fg="blue")
    lbl_base.pack()

    def change_base():
        p = filedialog.askdirectory(title="Nova Pasta Base")
        if p:
            p = path_norm(p)
            if messagebox.askyesno("Confirmar", f"Alterar para:\n{p}?"):
                cfg["base_path"] = p
                config_save(cfg)
                lbl_base.config(text=path_shorten(p))

    tk.Button(root, text="Alterar Pasta Base", command=change_base).pack(pady=4)

    scan_path = tk.StringVar(value="")
    recursive = tk.BooleanVar(value=False)

    tk.Label(root, text="Escaneamento", font=("Arial", 11)).pack(pady=8)

    def select_scan():
        p = filedialog.askdirectory(title="Selecione a pasta para escanear")
        if p:
            p = path_norm(p)
            scan_path.set(p)
            lbl_scan.config(text=path_shorten(p))

    tk.Button(root, text="Selecionar pasta", command=select_scan).pack()
    lbl_scan = tk.Label(root, text="Nenhuma pasta selecionada", fg="green")
    lbl_scan.pack(pady=3)
    tk.Checkbutton(root, text="Incluir Subpastas", variable=recursive).pack()

    file_mode = tk.StringVar(value=cfg.get("file_mode", "both"))

    def save_mode():
        cfg["file_mode"] = file_mode.get()
        config_save(cfg)

    tk.Label(root, text="Tipo de arquivo:", font=("Arial", 10)).pack()
    tk.Radiobutton(root, text="LUA + XML", value="both", variable=file_mode, command=save_mode).pack()
    tk.Radiobutton(root, text="Somente LUA", value="lua", variable=file_mode, command=save_mode).pack()
    tk.Radiobutton(root, text="Somente XML", value="xml", variable=file_mode, command=save_mode).pack()

    export_dir = tk.StringVar(value=cfg["last_export_path"])

    tk.Label(root, text="Exportação", font=("Arial", 11)).pack(pady=8)

    def select_export():
        p = filedialog.askdirectory(initialdir=cfg["last_export_path"], title="Selecione pasta para exportar")
        if p:
            p = path_norm(p)
            cfg["last_export_path"] = p
            config_save(cfg)
            export_dir.set(p)
            lbl_export.config(text=path_shorten(p))

    tk.Button(root, text="Selecionar pasta", command=select_export).pack()

    lbl_export = tk.Label(root, text=path_shorten(cfg["last_export_path"]), fg="orange")
    lbl_export.pack(pady=3)

    tk.Label(root, text="Máximo de arquivos por TXT:").pack()
    limit = tk.IntVar(value=3)
    tk.Entry(root, textvariable=limit, width=5).pack()

    result = {"ok": False}

    def run_scan():
        if not scan_path.get():
            messagebox.showerror("Erro", "Selecione a pasta para escanear.")
            return

        d = path_norm(scan_path.get())
        if not os.path.isdir(d):
            messagebox.showerror("Erro", "Pasta não existe.")
            return

        status.set("Escaneando...")
        root.update_idletasks()

        lua, xml = scan_collect(d, recursive.get(), file_mode.get())
        total = len(lua) + len(xml)

        msg = (
            f"Pasta: {d}\n\n"
            f"LUA: {len(lua)}\n"
            f"XML: {len(xml)}\n"
            f"TOTAL: {total}"
        )

        messagebox.showinfo("Preview", msg)

        result["scan_lua"] = len(lua)
        result["scan_xml"] = len(xml)

        status.set("Pronto.")

    def run_extract():
        if result.get("scan_lua", 0) == 0 and result.get("scan_xml", 0) == 0:
            messagebox.showerror("Erro", "Faça o escaneamento primeiro.")
            return

        try:
            lim = int(limit.get())
            if lim <= 0:
                raise Exception()
        except:
            messagebox.showerror("Erro", "Limite inválido.")
            return

        result.update({
            "ok": True,
            "scan_path": scan_path.get(),
            "export_path": export_dir.get(),
            "recursive": recursive.get(),
            "limit": lim,
            "mode": file_mode.get()
        })

        root.destroy()

    def run_import():
        root.destroy()
        import_engine()

    tk.Button(root, text="ESCANEAR", width=14, command=run_scan).pack(pady=4)
    tk.Button(root, text="EXTRAIR", width=14, command=run_extract).pack(pady=4)
    tk.Button(root, text="IMPORTAR TXT", width=14, command=run_import).pack(pady=4)
    tk.Button(root, text="SAIR", width=14, command=root.destroy).pack(pady=6)

    root.mainloop()
    return result


def main():
    cfg = config_load()
    opts = gui_main()
    if not opts["ok"]:
        return

    export_engine(
        cfg,
        path_norm(opts["scan_path"]),
        path_norm(opts["export_path"]),
        opts["recursive"],
        opts["limit"],
        opts["mode"]
    )


if __name__ == "__main__":
    main()
