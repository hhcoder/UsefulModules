#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <iterator>

// Caller should catch like following
// catch (bad_alloc& ba) 
// {
//     std::cerr << "ERROR: ";
//     std::cerr << ba.what() << endl;
//     throw ba;
// }
// catch (std::ofstream::failure e)
// {
//     std::cout << "***** Error writing to file: " << out_fname << std::endl;
//     throw e;
// }

// template <typename T>
// class FileReader : public std::vector<std::vector<T>>
// {
// public:
//     FileReader(
//             const std::string& dir, 
//             const std::vector<std::string> &file_names,
//             const size_t elem_count
//             )
//         : std::vector<std::vector<T>>(file_names.size(), std::vector<T>(elem_count))
//     {
//         for (int i=0; i<this->size(); i++ )
//         {
//             std::ifstream in_file(dir + "/" + file_names[i], std::ios::binary);
//
//             in_file.exceptions(std::ios::badbit);
//
//             // static or reinterpret?
//             // in_file.read(
//             //         reinterpret_cast<char*>(this->at(i).begin()), 
//             //         this->at(i).size()*sizeof(T));
//         }
//     }
//
//     ~FileReader() { }
//
// private:
//     void ReadFromFile(std::string& in_fname, std::vector<T>& vec)
//     {
//     }
// };

template <typename T> constexpr T &lvalue(T &&r) noexcept { return r; }

template <typename T>
std::vector<T> VectorFromFile(const std::string& file_path)
{
    return {
      std::istream_iterator<T>(lvalue(std::ifstream(file_path, std::ios::binary))),
      {}
    };
}

int main(int argc, char* argv[])
{
    const std::string directory("./");
    std::vector<std::string> file_names;
    file_names.emplace(file_names.end(), "data1.bin");
    file_names.emplace(file_names.end(), "data2.bin");

    for (auto i:file_names)
        std::cout << i << std::endl;

    // FileReader<uint8_t> bin_files(directory, file_names, 2322);



  return  0;
}
