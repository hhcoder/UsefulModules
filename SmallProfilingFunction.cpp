#include <chrono>
#include <utility>

namespace Profiling
{
    struct MeasureTime 
    {
        MeasureTime(const std::string& in_title)
            : start(std::chrono::system_clock::now()),
              title(in_title){};
        ~MeasureTime()
        {
            auto end = std::chrono::system_clock::now();
            std::chrono::duration<double> diff = end-start;
            std::cout << title << ": " << diff.count() << " s" << std::endl;
        }
        decltype(std::chrono::system_clock::now()) start;
        std::string title;
    };

    template <typename FxnType, typename... Args>
        void FxnTime(const std::string& str, FxnType f, Args&&... args)
    {
        MeasureTime m(str);
        f(std::forward<decltype(args)>(args)...);
    }
}
