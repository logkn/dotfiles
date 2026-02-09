function update-llamacpp
    set -l original_dir (pwd)
    # Define the absolute path to llama.cpp
    set LLAMA_DIR "/run/media/logan/storage/Development/OpenSource/llama.cpp"
    set -x CMAKE_BUILD_PARALLEL_LEVEL (nproc)

    if not test -d $LLAMA_DIR
        echo "Error: $LLAMA_DIR does not exist!"
        exit 1
    end

    cd $LLAMA_DIR
    echo "Updating llama.cpp..."
    git pull --rebase

    # Clean build to avoid stale CMake cache/config options
    rm -rf build
    mkdir -p build
    cd build

    echo "Configuring build..."
    cmake .. \
        -DGGML_CUDA=ON \
        -DLLAMA_CURL=ON \
        -DLLAMA_OPENSSL=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -G Ninja \
        -DCMAKE_CXX_FLAGS="-flto"

    echo "Building..."
    cmake --build .

    echo "✅ Update and build complete!"

    cd $original_dir
end
