function update-llamacpp
    set -l original_dir (pwd)
    # Define the absolute path to llama.cpp
    set LLAMA_DIR "/run/media/logan/storage/Development/OpenSource/llama.cpp"

    # Set max parallel build jobs
    set -x CMAKE_BUILD_PARALLEL_LEVEL (nproc)

    # Ensure the directory exists
    if not test -d $LLAMA_DIR
        echo "Error: $LLAMA_DIR does not exist!"
        exit 1
    end

    # Navigate to the project directory
    cd $LLAMA_DIR

    # Update repo
    echo "Updating llama.cpp..."
    git pull --rebase

    # Create and enter the build directory
    mkdir -p build
    cd build

    # Run CMake with optimizations
    echo "Configuring build..."
    cmake .. -DGGML_CUDA=ON -DLLAMA_CURL=ON \
        -DCMAKE_BUILD_TYPE=Release -G Ninja \
        -DCMAKE_CXX_FLAGS="-flto"

    # Build the project
    echo "Building..."
    cmake --build .

    echo "✅ Update and build complete!"

    cd $original_dir
end
