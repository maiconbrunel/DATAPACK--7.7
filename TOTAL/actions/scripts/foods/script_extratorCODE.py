#!/usr/bin/env python3
# Script Extrator Final - Apenas diretório atual, lógica 100% corrigida

import os
import tkinter as tk
from tkinter import messagebox

ERROR_LOG = "errors.txt"


# ---------------------------
# Criar nome único
# ---------------------------
def unique_filename(name):
    if not os.path.exists(name):
        return name
    base, ext = os.path.splitext(name)
    i = 1
    while True:
        new = f"{base} ({i}){ext}"
        if not os.path.exists(new):
            return new
        i += 1


# ---------------------------
# Apagar apenas TXT gerados pelo extrator
# ---------------------------
def delete_old_txt():
    for f in os.listdir("."):
        if f.endswith(".txt") and f != ERROR_LOG:
            # Apagar apenas arquivos criados pelo extrator
            if f.startswith("extracted"):
                try:
                    os.remove(f)
                except:
                    pass


# ---------------------------
# Criar writer de arquivo TXT
# ---------------------------
def create_writer(part, overwrite):
    filename = "extracted.txt" if part == 1 else f"extracted_part{part}.txt"

    # Se não sobrescrever, cria variante única
    if not overwrite:
        filename = unique_filename(filename)

    # Append sempre → nunca perde dados
    return open(filename, "a", encoding="utf-8"), filename


# ---------------------------
# GUI de opções
# ---------------------------
def ask_options(lua_count, xml_count):
    root = tk.Tk()
    root.title("Script Extrator")

    tk.Label(
        root,
        text=f"Arquivos encontrados:\n{lua_count} LUA\n{xml_count} XML",
        font=("Arial", 11)
    ).pack(pady=10)

    lua_var = tk.BooleanVar(value=True)
    xml_var = tk.BooleanVar(value=True)
    clear_var = tk.BooleanVar(value=False)
    overwrite_var = tk.BooleanVar(value=True)

    tk.Checkbutton(root, text="Extrair LUA", variable=lua_var).pack(anchor="w", padx=20)
    tk.Checkbutton(root, text="Extrair XML", variable=xml_var).pack(anchor="w", padx=20)
    tk.Checkbutton(root, text="Apagar TXT antigos", variable=clear_var).pack(anchor="w", padx=20)
    tk.Checkbutton(root, text="Sobrescrever TXT existentes", variable=overwrite_var).pack(anchor="w", padx=20)

    tk.Label(root, text="Máximo de arquivos por TXT:").pack(pady=(10, 0))
    limit_var = tk.IntVar(value=3)
    tk.Entry(root, textvariable=limit_var, width=5).pack()

    result = {"ok": False}

    def start():
        try:
            limit = int(limit_var.get())
            if limit <= 0:
                raise ValueError
        except:
            messagebox.showerror("Erro", "Digite um número válido maior que 0.")
            return

        if not lua_var.get() and not xml_var.get():
            messagebox.showerror("Erro", "Selecione ao menos um tipo de arquivo.")
            return

        result.update({
            "ok": True,
            "extract_lua": lua_var.get(),
            "extract_xml": xml_var.get(),
            "limit": limit,
            "clear": clear_var.get(),
            "overwrite": overwrite_var.get(),
        })

        root.destroy()

    def cancel():
        root.destroy()

    frame = tk.Frame(root)
    frame.pack(pady=10)
    tk.Button(frame, text="OK", width=10, command=start).grid(row=0, column=0, padx=10)
    tk.Button(frame, text="Cancelar", width=10, command=cancel).grid(row=0, column=1, padx=10)

    root.mainloop()
    return result


# ---------------------------
# Main
# ---------------------------
def main():
    base_dir = os.path.abspath(".")

    lua_files = []
    xml_files = []

    # SOMENTE diretório atual
    for f in os.listdir(base_dir):
        full = os.path.join(base_dir, f)
        if os.path.isfile(full):
            if f.lower().endswith(".lua"):
                lua_files.append(f)
            elif f.lower().endswith(".xml"):
                xml_files.append(f)

    opts = ask_options(len(lua_files), len(xml_files))
    if not opts["ok"]:
        return

    selected = []
    if opts["extract_lua"]:
        selected += lua_files
    if opts["extract_xml"]:
        selected += xml_files

    selected.sort()

    # Apagar TXT antigos se marcado
    if opts["clear"]:
        delete_old_txt()

    # Limpar erros anteriores
    if os.path.exists(ERROR_LOG):
        os.remove(ERROR_LOG)

    extracted_size = 0
    part = 1
    count = 0

    writer, _ = create_writer(part, opts["overwrite"])

    # LOOP PRINCIPAL — LÓGICA CORRIGIDA
    for filename in selected:

        # Abre arquivo
        try:
            with open(filename, "r", encoding="utf-8") as f:
                content = f.read()
        except Exception as e:
            with open(ERROR_LOG, "a", encoding="utf-8") as err:
                err.write(f"Erro lendo {filename}: {e}\n")
            continue

        # Conteúdo formatado
        block = (
            f"===== FILE_START: {filename} =====\n"
            f"{content}\n"
            f"===== FILE_END =====\n\n"
        )

        extracted_size += len(block.encode("utf-8"))

        # Se atingir o limite → cria novo arquivo TXT
        if count >= opts["limit"]:
            writer.close()
            part += 1
            count = 0
            writer, _ = create_writer(part, opts["overwrite"])

        writer.write(block)
        count += 1

    writer.close()

    tk.Tk().withdraw()
    messagebox.showinfo(
        "Script Extrator",
        f"Extração concluída!\nTotal extraído: {extracted_size/1024:.2f} KB"
    )


if __name__ == "__main__":
    main()
