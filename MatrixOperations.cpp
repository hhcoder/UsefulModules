#include <stdio.h>
#include <stdlib.h>
#include <time.h>

class Matrix3x3
{
public:
  enum INITALIZER
  {
    UNITY,
    RANDOM,
    EMPTY
  };

  Matrix3x3(INITALIZER i)
  {
    switch(i)
    {
        case UNITY:
          SetToUnity();
        break;
        case RANDOM:
          SetToRandom();
        break;
        default:
        case EMPTY:
          SetToEmpty();
        break;
    }
  }

private:
    void SetToEmpty()
    {
        for(int i=0; i<9; i++)
            Set(i, 0.0f);
    }

    void SetToUnity()
    {
        SetToEmpty();
        Set(0, 0, 1.0f);
        Set(1, 1, 1.0f);
        Set(2, 2, 1.0f);
    }

    void SetToRandom()
    {
        srand(time(NULL));
        for(int i=0; i<9; i++)
            Set(i, (rand()%1000)/10.0f);
    }

public:
   bool operator==(const Matrix3x3& a)
  {
      for(unsigned int i=0; i<9; i++)
      {
        if(a.val[i]!=this->val[i])
          return false;
      }
      return true;
  }

  Matrix3x3& operator*(const Matrix3x3& a)
  {
    for(int c=0; c<3; c++)
    {
        for(int r=0; r<3; r++)
        {
            ElementMultiply(a, c, r);
        }
    }
    return *this;
  }

private:
  void ElementMultiply(const Matrix3x3& a, const unsigned int c, const unsigned int r)
  {
      float t = Get(c,0)*a.Get(0,r) + Get(c,1)*a.Get(1,r) + Get(c,2)*a.Get(2,r);
      Set(c, r, t);
  }

public:
  void Print()
  {
      for(int c=0; c<3; c++)
      {
          for(int r=0; r<3; r++)
          {
              printf(" %f ", Get(c,r));
          }
          printf("\n");
      }
  }

public:
  float Get(const unsigned int idx) const
  {
    //TODO: add error handling for out of boundary access
    return val[idx];
  }

  float Get(const unsigned int col_idx, const unsigned row_idx) const
  {
    //TODO: add error handling for out of boundary access
    return val[row_idx*3+col_idx];
  }

  void Set(const unsigned int idx, const float in)
  {
    //TODO: add error handling for out of boundary access
    val[idx] = in;
  }

  void Set(const unsigned int col_idx, const unsigned row_idx, const float in)
  {
    //TODO: add error handling for out of boundary access
    val[row_idx*3+col_idx] = in;
  }

private:
  float val[9];
};


int main(int argc, char* argv[])
{
  Matrix3x3 a(Matrix3x3::RANDOM);
  Matrix3x3 b(Matrix3x3::UNITY);
  Matrix3x3 c(Matrix3x3::EMPTY);

  a.Print();
  b.Print();
  c.Print();

  if(true!=(a==a))
  {
    printf("fail!\n");
    return -1;
  }

  c = a * b;
  c.Print();

  if(true!=(c==a))
  {
    printf("fail!\n");
    return -1;
  }

  printf("success!\n");

  return 0;
}
