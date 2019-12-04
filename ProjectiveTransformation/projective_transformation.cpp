#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

#if defined __UINT32_MAX__ or UINT32_MAX
    #include <inttypes.h>
#else
    typedef unsigned char uint8_t;
    typedef unsigned int uint32_t;
#endif

class Image
{
public:
    Image(const uint32_t iw, const uint32_t ih)
        : width(iw), height(ih), size_bytes(iw*ih), buf(NULL)
    {
    }

    ~Image()
    {
        if(NULL==buf)
            delete[] buf;
    }

    uint32_t Allocate()
    {
        if(NULL!=buf)
            return FAIL;
        buf = new uint8_t[size_bytes];
        if(NULL==buf)
            return FAIL;
        return SUCCESS;
    }

    void Clear(const uint8_t ival)
    {
        if(NULL==buf)
            memset(buf, ival, size_bytes);
    }

    inline uint32_t GetWidth() const { return width; }
    inline uint32_t GetHeight() const { return height; }

    uint8_t GetPixel(const uint32_t x, const uint32_t y) { if(x<width&&y<height) return buf[y*width+x]; else return 0; }
    void SetPixel(const uint32_t x, const uint32_t y, const uint8_t ival) { if(x<width&&y<height) buf[y*width+x] = ival; }

public:
    uint32_t Write(const char* ofname)
    {
        FILE* fp = fopen(ofname, "wb");
        if(NULL==fp)
        {
            printf("Error when creating: %s\n", ofname);
            return FAIL;
        }

        if( size_bytes!= fwrite(buf, sizeof(uint8_t), size_bytes, fp))
        {
            printf("Error when writing: %s\n", ofname);
            return FAIL;
        }

        fclose(fp);
        return SUCCESS;
    }

public:
    static const uint32_t SUCCESS;
    static const uint32_t FAIL;
    static bool IsSuccess(const uint32_t icode) { return icode==SUCCESS; }
    static bool IsFail(const uint32_t icode) { return !IsSuccess(icode); }

public:
    static const uint8_t BLACK;
    static const uint8_t WHITE;

private:
    uint32_t width;
    uint32_t height;
    uint32_t size_bytes;
    uint8_t* buf;
};

const uint32_t Image::SUCCESS = 0x00;
const uint32_t Image::FAIL = 0x01;

const uint8_t Image::BLACK = 0x00;
const uint8_t Image::WHITE = 0xFF;

class ContentGenerate
{
public:
    static Image* CheckerBoard(const uint32_t iblock_size, const uint32_t iwidth_count, const uint32_t iheight_count);
    static inline bool IsEven(const uint32_t x) { return ((x&0x01)==0x00); }
    static inline bool IsOdd(const uint32_t x) { return ((x&0x01)==0x01); }
};

Image* ContentGenerate::CheckerBoard(const uint32_t iblock_size, const uint32_t iwidth_count, const uint32_t iheight_count)
{
    Image* img = new Image(iblock_size*iwidth_count, iblock_size*iheight_count);
    img->Allocate();
    img->Clear(Image::BLACK);
    for(uint32_t j=0; j<img->GetHeight(); j++)
        for(uint32_t i=0; i<img->GetWidth(); i++)
        {
            uint32_t yidx = j/iblock_size;
            uint32_t xidx = i/iblock_size;
            if(IsEven(yidx)&&IsEven(xidx))
                img->SetPixel(i, j, Image::WHITE);
            if(IsOdd(yidx)&&IsOdd(xidx))
                img->SetPixel(i, j, Image::WHITE);
        }
    return img;
}

class Matrix3x3
{
public:
    Matrix3x3()
    {
        M00 = 1.0f; M01 = 0.0f; M02 = 0.0f;
        M10 = 0.0f; M11 = 1.0f; M12 = 0.0f;
        M20 = 0.0f; M21 = 0.0f; M22 = 1.0f;
    }

    Matrix3x3(const float in[9])
    {
        M00 = in[0]; M01 = in[1]; M02 = in[2];
        M10 = in[3]; M11 = in[4]; M12 = in[5];
        M20 = in[6]; M21 = in[7]; M22 = in[8];
    }

    Matrix3x3(const float alpha, const float beta, const float gamma)
    {
        M00 = cos(alpha)*cos(beta);
        M01 = cos(alpha)*sin(beta)*sin(gamma)-sin(alpha)*cos(gamma);
        M10 = cos(alpha)*sin(beta)*cos(gamma)+sin(alpha)*sin(gamma);
        M10 = sin(alpha)*cos(beta);
        M11 = sin(alpha)*sin(beta)*sin(gamma)+cos(alpha)*cos(gamma);
        M12 = sin(alpha)*sin(beta)*cos(gamma)-cos(alpha)*sin(gamma);
        M20 = -sin(beta);
        M21 = cos(beta)*sin(gamma);
        M22 = cos(beta)*cos(gamma);
    }

    float M00, M01, M02;
    float M10, M11, M12;
    float M20, M21, M22;

    void Print()
    {
        printf("Matrix - \n");
        printf("  [ %f, %f, %f\n", M00, M01, M02);
        printf("    %f, %f, %f\n", M10, M11, M12);
        printf("    %f, %f, %f ]\n", M20, M21, M22);
    }
};

class Vector1x3
{
public:
    Vector1x3(const float in[3])
        : v0(in[0]), v1(in[1]), v2(in[2])
    {
    }

    Vector1x3(const float iv0, const float iv1, const float iv2)
        : v0(iv0), v1(iv1), v2(iv2)
    {
    }

    Vector1x3()
        : v0(0.0f), v1(0.0f), v2(0.0f)
    {
    }

    float v0;
    float v1;
    float v2;

public:
    Vector1x3& operator=(const Vector1x3& rhs)
    {
        if(this==&rhs)
            return *this;
        this->v1 = rhs.v1;
        this->v2 = rhs.v2;
        return *this;
    }

    Vector1x3 operator*(const Matrix3x3& rhs)
    {
        float v[3];
        v[0] = v0*rhs.M00 + v1*rhs.M01 + v2*rhs.M02;
        v[1] = v0*rhs.M10 + v1*rhs.M11 + v2*rhs.M12;
        v[2] = v0*rhs.M20 + v1*rhs.M21 + v2*rhs.M22;
        return Vector1x3(v);
    }

    void Print()
    {
        printf("Vector - %f, %f, %f\n", v0, v1, v2);
    }
};

void TestVector()
{
    Vector1x3 vec(1.5f, 3.9f, 8.8f);
    vec.Print();

    Matrix3x3 identity;
    identity.Print();

    Vector1x3 tmp = vec * identity;
    tmp.Print();
}

int main(int argc, char* argv[])
{
    TestVector();

    Image* checker_board = ContentGenerate::CheckerBoard(100, 10, 10);
    checker_board->Write("checker.y");
    delete checker_board;

    return 0;
}
