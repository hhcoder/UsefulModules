#include <iostream>
#include <fstream>
#include <string>
#include <vector>

template <typename T>
class Buf2D : public std::vector<T> 
{
public:
    using size_type = typename std::vector<T>::size_type;

public:
    Buf2D(const int in_width, const int in_height, const void* in_buf)
		: width(in_width), 
          height(in_height), 
          stride(width),
          std::vector<T>(PixelCount())
    {
        memcpy(this->begin(), in_buf, BinarySize());
    }

	~Buf2D() {}

	int Write(const std::string& out_fname)
	{
        std::ofstream out_file(out_fname.c_str(), std::ios::binary);
        try
        {
            out_file.exceptions(std::ios::badbit);
            out_file.write(this->begin(), BinarySize());
        }
        catch (std::ofstream::failure e)
        {
            std::cout << "***** Error writing to file: " << out_fname << std::endl;
            return 0;
        }
        return 1;
	}

public:
	inline int Width() const { return width; }
	inline int Height() const { return height; }
	inline int Stride() const { return stride; }
    inline size_type PixelCount() const { return this->size(); }
    inline size_type BinarySize() const { return PixelCount()*sizeof(T); }

protected:
	int width;
	int height;
	int stride;
};

