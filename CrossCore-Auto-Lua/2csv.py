import sys
from lupa import LuaRuntime
import pandas as pd
import os
import glob
from openpyxl import load_workbook

def luaTable2List(lua_table):
    return [lua_table[i+1] for i in range(len(lua_table))]

def lua_todata(source_path):
    with open(source_path, "r", encoding="utf-8") as f:
        lua_code = f.read()

    #判断是否是"local conf"开头
    if not lua_code.startswith("local conf"):
        #print("not start with local conf")
        return
    conf = lua.execute(lua_code)
    filename = conf["filename"]
    sheetname = conf["sheetname"]
    types_content = conf["types"]
    names_content = luaTable2List(conf["names"])
    data_content = [luaTable2List(conf["data"][i+1]) for i in range(len(conf["data"]))]

    if filename not in datas_dict:
        datas_dict[filename] = []
    datas_dict[filename].append((data_content, names_content, sheetname))

def datas_to_excel(filename, datas:list, target_dir): 
    if os.path.exists(os.path.join(target_dir, filename)):
        book = load_workbook(os.path.join(target_dir, filename))
        writer = pd.ExcelWriter(os.path.join(target_dir, filename), engine='openpyxl', mode='a', if_sheet_exists='new') 
        writer._workbook = book
    else:
        writer = pd.ExcelWriter(os.path.join(target_dir, filename), engine='openpyxl')

    for data_content,names_content,sheetname in datas:   
        df = pd.DataFrame(data_content, columns=names_content)
        df.to_excel(writer, sheet_name=sheetname, index=False)

    writer.close()


if __name__ == '__main__':
    in_path = sys.argv[1]
    out_path = sys.argv[2]

    lua = LuaRuntime(unpack_returned_tuples=True)

    datas_dict = {}

    files = glob.glob(os.path.join(in_path, 'cfg*.lua'))

    if not os.path.exists(out_path):
        os.makedirs(out_path)

    if not files:
        print('No files found')
        exit()

    for file in files:
        lua_todata(file)

    for filename, datas in datas_dict.items():
        datas_to_excel(filename, datas, out_path)