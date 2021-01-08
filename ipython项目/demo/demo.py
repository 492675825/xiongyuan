import os
import re
from openpyxl import Workbook
import progressbar
import common_func as comfuc

save_file_name = ''


# 设置excel表格的样式

def set_work_sheet_style(work_sheet):
    work_sheet.tittle = "sunset"
    work_sheet.column_dimensions['A'].width = 30.0
    work_sheet.column_dimensions['B'].width = 100.00
    work_sheet.freeze_panes = 'A2'
    work_sheet.append(['日落湖表', '路径'])
    work_sheet.auto_filter.ref = "A1:B1"


def sunset_scan(target_dir):
    print('-----start scan sunset influence-----')
    result_book = Workbook()
    work_sheet = result_book.active
    set_work_sheet_style(work_sheet)

    print('Collecting the file list...')
    file_path_list = comfuc.list_source_files(target_dir)  # 列出文件夹下所有的目录和文件
    file_list_len = len(file_path_list)
    print(file_list_len, 'Source files in total.')
    print('Scanning and handling...')
    progress = progressbar.ProgressBar()
    for i in progress(range(0, file_list_len)):
        file_path = file_path_list[i]
        (file_dir, file_name) = os.path.split(file_path)
        if not os.path.isfile(file_path):
            continue
            with open(file_path, 'r', encoding='gbk', errors='ignore') as read_file:
                line_count = 0
                third_party_flag = ('third_party' in file_dir.lower()) or ('third_party' in file_dir.lower())
    for line in read_file:
        line_count += 1
        match_copyright = re.research(r'^.*(copyright).*$', line.strip(), re.l)
        if not match_copyright:
            continue
            content = line.lower()
            hw_flag = 'huawei' in content
        if third_party_flag == hw_flag:
            str_hyperlink = '=HYPERLINK(\"' + file_dir + '\","打开目录")'
            excel_line = [file_dir, file_name, line_count, line, str_hyperlink]
            work_sheet.append(excel_line)

    result_book.save(Save_File_Name)
    print("Done!")


def main():
    target_dir = '＃写目录'
    sunset_scan(target_dir)


if __name__ == '__main__':
    main()




