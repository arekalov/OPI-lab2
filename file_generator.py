import os
import shutil

def main():
    HOME_PATH = "/Users/arekalov/Itmo/4/OPI/lab2/data"

    # Remove the directory if it exists
    if os.path.exists(HOME_PATH):
        shutil.rmtree(HOME_PATH)

    # Create the main directory
    os.makedirs(HOME_PATH)

    for i in range(40):
        current_dir_path = os.path.join(HOME_PATH, str(i))
        os.makedirs(current_dir_path)
        with open(os.path.join(current_dir_path, str(i)), 'w') as f:
            f.write(f"Data for commit {i}")

        if i != 0:
            prev_dir_path = os.path.join(HOME_PATH, str(i - 1))
            for root, dirs, files in os.walk(prev_dir_path):
                for file in files:
                    source = os.path.join(root, file)
                    target = os.path.join(current_dir_path, os.path.relpath(source, prev_dir_path))
                    # Create intermediate directories if they do not exist
                    os.makedirs(os.path.dirname(target), exist_ok=True)
                    shutil.copy2(source, target)

if __name__ == "__main__":
    main()
