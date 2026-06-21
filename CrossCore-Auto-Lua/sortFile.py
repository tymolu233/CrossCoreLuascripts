import os
import re
import sys
import json
import shutil
import concurrent.futures

def save_structure(directory, output_file):
    structure = {}
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("CAD_") or file.startswith("FBD_") or file.startswith("SD_"):
                continue
            relative_path = os.path.relpath(root, directory)
            structure[file] = relative_path.replace("\\", "/")
    with open(output_file, 'w') as f:
        json.dump(structure, f, indent=4)

def copy_files(src_directory, dst_directory, structure_file):
    with open(structure_file, 'r') as f:
        structure = json.load(f)
    with concurrent.futures.ThreadPoolExecutor() as executor:
        for file in os.listdir(src_directory):
            filename = file.split(".")[0] + ".lua"
            if filename in structure:
                dst_path = os.path.join(dst_directory, structure[filename])
            else:
                if file.startswith("cfg"):
                    dst_path = os.path.join(dst_directory, "cfg")
                elif file.startswith("CAD_"):
                    dst_path = os.path.join(dst_directory, "Exports", "CameraActions")
                elif file.startswith("FBD_"):
                    dst_path = os.path.join(dst_directory, "Exports", "FireBalls")
                elif file.startswith("SD_"):
                    dst_path = os.path.join(dst_directory, "Exports", "States")
                elif file.startswith("Dungeon_"):
                    dst_path = os.path.join(dst_directory, "Dungeons")
                elif file.startswith("Map_"):
                    dst_path = os.path.join(dst_directory, "Maps")
                elif re.match(r'Buffer\d+\.lua\.txt$', file):
                    dst_path = os.path.join(dst_directory, "Buffers")
                elif re.match(r'Skill\d+\.lua\.txt$', file):
                    dst_path = os.path.join(dst_directory, "Skills")
                else:
                    dst_path = os.path.join(dst_directory, "Others")
            if not os.path.exists(dst_path):
                os.makedirs(dst_path)
            executor.submit(copy_file, os.path.join(src_directory, file), os.path.join(dst_path, filename))

def copy_file(src, dst):
    shutil.copy(src, dst)

def update_structure(directory, structure_file):
    # 读取旧的结构
    with open(structure_file, 'r') as f:
        structure = json.load(f)

    # 获取新的目录结构
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("CAD_") or file.startswith("FBD_") or file.startswith("SD_"):
                continue
            relative_path = os.path.relpath(root, directory)
            structure[file] = relative_path.replace("\\", "/")
    
    structure = dict(sorted(structure.items(), key=lambda item: (item[1], item[0])))

    # 将更新后的结构写回文件
    with open(structure_file, 'w') as f:
        json.dump(structure, f, indent=4)

if __name__ == '__main__':

    in_path = sys.argv[1]
    out_path = sys.argv[2]
    structure_path = sys.argv[3]

    if not os.path.exists(out_path):
        os.makedirs(out_path)
        print(f"Create directory: {out_path}")

    copy_files(in_path, out_path, structure_path)
    print(f"Copy files from {in_path} to {os.path.abspath(out_path)} successfully")