import os

# Get the directory of the current script (pdf.py)
script_directory = os.path.dirname(os.path.realpath(__file__))

import pickle

from pypdf import PdfReader, PdfWriter


def unlock_pdf(pdf_file):
    reader = PdfReader(pdf_file)

    if reader.is_encrypted:
        with open(os.path.join(script_directory, "passwords.txt"), "r") as file:
            for line in file:
                password = line.strip()
                try:
                    if reader.decrypt(password):
                        print(f"Password found: {password}")
                        break
                except Exception as e:
                    print(f"Error trying password {password}: {e}")
        writer = PdfWriter(clone_from=reader)

        # Save the new PDF to a file
        with open(pdf_file, "wb") as f:
            writer.write(f)
        print(f"{pdf_file} has been unlocked.")
    else:
        print(f"{pdf_file} is not encrypted.")


def get_pdf_files_in_directory(directory):
    return {file for file in os.listdir(directory) if file.endswith(".pdf")}


def find_new_files(directory, old_files):
    current_files = get_pdf_files_in_directory(directory)
    new_files = current_files - old_files

    # Check if any of the new files have a ".crdownload" extension
    new_files = [file for file in new_files if not file.endswith(".crdownload")]
    return new_files


def save_file_list(file_path, file_list):
    with open(file_path, "wb") as f:
        pickle.dump(file_list, f)


def load_file_list(file_path):
    if os.path.exists(file_path):
        with open(file_path, "rb") as f:
            return pickle.load(f)
    return set()


def main():
    directory = "/Users/rahul286/Downloads"
    storage_file = os.path.join(script_directory, "file-list.pkl")

    # Load the previous list of files
    old_files = load_file_list(storage_file)

    # Get the current list of files
    current_files = get_pdf_files_in_directory(directory)

    # Find new files
    new_files = find_new_files(directory, old_files)

    if new_files:
        print("New PDF file(s) found")
        for file in new_files:
            print(file)
            unlock_pdf(os.path.join(directory, file))
            # open the file using MacOS open command
            os.system(f'open "{os.path.join(directory, file)}"')
    else:
        print("No newly created PDF file(s) found.")

    # Save the current list of files for the next run
    save_file_list(storage_file, current_files)


if __name__ == "__main__":
    main()
