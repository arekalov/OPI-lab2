import os
import shutil
import argparse

def main(home_path):
    # Remove the directory if it exists
    if os.path.exists(home_path):
        shutil.rmtree(home_path)

    # Create the main directory
    os.makedirs(home_path)

    for i in range(40):
        current_dir_path = os.path.join(home_path, str(i))
        os.makedirs(current_dir_path)
        with open(os.path.join(current_dir_path, str(i)), 'w') as f:
            f.write(f"Data for commit {i}")

        if i != 0:
            prev_dir_path = os.path.join(home_path, str(i - 1))
            for root, dirs, files in os.walk(prev_dir_path):
                for file in files:
                    source = os.path.join(root, file)
                    target = os.path.join(current_dir_path, os.path.relpath(source, prev_dir_path))
                    # Create intermediate directories if they do not exist
                    os.makedirs(os.path.dirname(target), exist_ok=True)
                    shutil.copy2(source, target)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate directory structure for commits.")
    parser.add_argument('home_path', type=str, help='The base path for creating the directory structure.')
    
    args = parser.parse_args()
    main(args.home_path)
