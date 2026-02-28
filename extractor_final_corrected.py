#!/usr/bin/env python3
# Extractor + Importer (Professional Layered / Clean / Corrected)

"""
VERSÃO FINAL – CORRIGIDA
• Nenhuma função chamada antes de ser definida
• BasePath não interfere no scan
• Exportação 100% correta para diretório selecionado
• Importador seguro, sem duplicação, sem caminhos inválidos
• Estrutura B2 (profissional, modular, organizada)
• Compatível com Windows / Linux / Mac
• Simples, funcional, robusto
"""

import os
import json
import platform
import tkinter as tk
from tkinter import messagebox, filedialog


# ============================================================
# HELPERS (sempre primeiro para evitar NameError)
# ============================================================

def path_norm(p):
    return os.path.abspath(p).replace("\\", "/")


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
        new = os.path.join(directory, f"{base} ({i}){ext}")
        if not os.path.exists(new):
            return new
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

CONFIG_FILE = ".extractor_config.json"

def config_load():
    if os.path.exists(CONFIG_FILE):
        try:
            with open(CONFIG_FILE, "r", encoding="utf-8") as f:
                cfg = json.load(f)
                cfg["base_path"] = path_norm(cfg.get("base_path", os.getcwd()))
                cfg["last_export_path"] = path_norm(cfg.get("last_export_path", os.getcwd()))
                return cfg
        except:
            pass

    base = filedialog.askdirectory(title="Selecione a Pasta Base (referência)")
    if not base:
        messagebox.showerror("Erro", "Nenhuma pasta base selecionada.")
        exit()

    cfg = {
        "base_path": path_norm(base),
        "last_export_path": path_norm(os.getcwd())
    }
    config_save(cfg)
    return cfg


def config_save(cfg):
    with open(CONFIG_FILE, "w", encoding="utf-8") as f:
        json.dump(cfg, f, indent=4)


# ============================================================
# SCAN ENGINE
# ============================================================

def scan_collect(scan_dir, recursive):
    scan_dir = path_norm(scan_dir)
    lua, xml = [], []

    if recursive:
        for r, _, files in os.walk(scan_dir):
            for f in files:
                fp = path_norm(os.path.join(r, f))
                if f.lower().endswith(".lua"):
                    lua.append(fp)
                elif f.lower().endswith(".xml"):
                    xml.append(fp)
    else:
        for f in os.listdir(scan_dir):
            fp = path_norm(os.path.join(scan_dir, f))
            if not os.path.isfile(fp):
                continue
            if f.lower().endswith(".lua"):
                lua.append(fp)
            elif f.lower().endswith(".xml"):
                xml.append(fp)

    return lua, xml


# ============================================================
# IMPORT ENGINE
# ============================================================

def import_engine():
    cfg = config_load()
    base = cfg["base_path"]

    txt_path = filedialog.askopenfilename(
        title="Selecione o TXT Modificado",
        filetypes=[("TXT", "*.txt")]
    )
    if not txt_path:
        return

    txt_path = path_norm(txt_path)

    # Escolher modo
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

    if mode == "manual":
        manual = filedialog.askdirectory(title="Escolha pasta destino")
        if not manual:
            messagebox.showerror("Erro", "Nenhuma pasta selecionada.")
            return
        manual = path_norm(manual)
    else:
        manual = None

    # Lendo TXT
    try:
        with open(txt_path, "r", encoding="utf-8") as f:
            data = f.read()
    except:
        messagebox.showerror("Erro", "Falha ao ler arquivo.")
        return

    if "===== FILE_START:" not in data:
        messagebox.showerror("Erro", "Nenhum bloco FILE_START encontrado.")
        return

    blocks = data.split("===== FILE_START: ")[1:]
    used = set()
    ok = skip = fail = 0

    for block in blocks:
        try:
            if " =====" not in block:
                skip += 1
                continue

            rel, rest = block.split(" =====", 1)
            rel = rel.strip()

            if rel in used:
                skip += 1
                continue
            used.add(rel)

            if "#<ABSOLUTE_PATH>" not in rest:
                fail += 1
                continue

            abs_path = rest.split("#<ABSOLUTE_PATH>")[1].split("</ABSOLUTE_PATH>")[0].strip()
            abs_path = path_norm(abs_path)

            if "===== FILE_END" not in rest:
                fail += 1
                continue

            content = rest.split("</ABSOLUTE_PATH>")[1].split("===== FILE_END")[0].lstrip("\n")
            if not content.strip():
                skip += 1
                continue

            # Definir destino final
            if mode == "auto":
                final = abs_path
                if not final.startswith(base):
                    fail += 1
                    continue

            elif mode == "manual":
                final = path_norm(os.path.join(manual, rel))

            else:  # sandbox
                final = path_norm(os.path.join(os.getcwd(), rel))
                if not final.startswith(path_norm(os.getcwd())):
                    fail += 1
                    continue

            # Criar pastas
            os.makedirs(os.path.dirname(final), exist_ok=True)

            # Backup seguro
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
                    pass

            # Gravar conteúdo
            with open(final, "w", encoding="utf-8") as w:
                w.write(content)

            ok += 1

        except Exception as e:
            errlog(f"Erro inesperado: {e}")
            fail += 1

    messagebox.showinfo("Importação concluída",
        f"Reinseridos: {ok}\nPulados: {skip}\nErros: {fail}")


# ============================================================
# EXPORT ENGINE
# ============================================================

def export_engine(cfg, scan_path, export_path, recursive, limit):
    lua, xml = scan_collect(scan_path, recursive)
    selected = sorted(lua + xml)

    if not selected:
        messagebox.showerror("Erro", "Nenhum arquivo encontrado.")
        return

    total_size = 0
    part = 1
    count = 0

    out_file = filename_unique("extracted.txt", export_path)

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
            out_file = filename_unique(f"extracted_part{part}.txt", export_path)
            writer = open(out_file, "a", encoding="utf-8")
            count = 0

        writer.write(block)
        count += 1

    writer.close()
    folder_open(export_path)

    messagebox.showinfo("Extração concluída",
        f"Pasta: {export_path}\n"
        f"Tamanho: {total_size/1024:.2f} KB\n"
        f"Partes: {part}")


# ============================================================
# GUI LAYER
# ============================================================

def gui_main():
    cfg = config_load()

    root = tk.Tk()
    root.title("Extractor + Importador")

    status = tk.StringVar(value="Pronto.")
    tk.Label(root, textvariable=status, relief="sunken", anchor="w").pack(side="bottom", fill="x")

    # Pasta Base
    tk.Label(root, text="Pasta Base (referência):", font=("Arial", 10, "bold")).pack()
    lbl_base = tk.Label(root, text=path_shorten(cfg["base_path"]), fg="blue")
    lbl_base.pack()

    def change_base():
        p = filedialog.askdirectory(title="Nova Pasta Base")
        if not p:
            return
        p = path_norm(p)
        if messagebox.askyesno("Confirmar", f"Alterar para:\n{p}?"):
            cfg["base_path"] = p
            config_save(cfg)
            lbl_base.config(text=path_shorten(p))

    tk.Button(root, text="Alterar Pasta Base", command=change_base).pack(pady=4)

    # SCAN
    scan_path = tk.StringVar(value="")
    recursive = tk.BooleanVar(value=False)

    def select_scan_folder():
        p = filedialog.askdirectory(title="Selecione a pasta para escanear")
        if not p:
            return
        p = path_norm(p)
        scan_path.set(p)
        lbl_scan.config(text=path_shorten(p))

    tk.Label(root, text="Escaneamento", font=("Arial", 11)).pack(pady=8)
    tk.Button(root, text="Selecionar pasta para escanear", command=select_scan_folder).pack()
    lbl_scan = tk.Label(root, text="Nenhuma pasta selecionada", fg="green")
    lbl_scan.pack(pady=3)
    tk.Checkbutton(root, text="Incluir Subpastas", variable=recursive).pack()

    # EXPORT
    export_dir = tk.StringVar(value=cfg["last_export_path"])

    def select_export_folder():
        p = filedialog.askdirectory(initialdir=cfg["last_export_path"], title="Selecione pasta para exportar")
        if not p:
            return
        p = path_norm(p)
        cfg["last_export_path"] = p
        config_save(cfg)
        export_dir.set(p)
        lbl_export.config(text=path_shorten(p))

    tk.Label(root, text="Exportação", font=("Arial", 11)).pack(pady=8)
    tk.Button(root, text="Selecionar pasta para exportar", command=select_export_folder).pack()
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

        lua, xml = scan_collect(d, recursive.get())
        total = len(lua) + len(xml)

        subs = []
        if recursive.get():
            for r, dirs, _ in os.walk(d):
                for dd in dirs:
                    subs.append(path_norm(os.path.join(r, dd)))

        msg = (
            f"Pasta: {d}\n\n"
            f"LUA: {len(lua)}\n"
            f"XML: {len(xml)}\n"
            f"Total: {total}"
        )
        if recursive.get():
            msg += f"\nSubpastas: {len(subs)}"

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
            "limit": lim
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


# ============================================================
# MAIN PROGRAM
# ============================================================

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
        opts["limit"]
    )


if __name__ == "__main__":
    main()
