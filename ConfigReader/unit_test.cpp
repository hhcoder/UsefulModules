#include "./cfg_reader.h"

std::vector<std::string> GetInputNames(ConfigReader& cfg, int32_t num_raws)
{
    std::vector<std::string> in_names;

    for (int32_t i=0; i<num_raws; i++)
    {
        char c_input_raw[128];
        memset(c_input_raw, 0x00, sizeof(c_input_raw));
        sprintf(c_input_raw, "InputRaw%d", i);
        std::string str_input_raw(c_input_raw);

        in_names.push_back(cfg.Get(str_input_raw));
    }

    return in_names;
}

int main(int argc, const char* argv[]) 
{
    if (argc < 2) 
    {
        std::cerr << "Usage: " << argv[0] << " config file path" << std::endl;
        return -1;
    }

    try
    {
        std::string in_file_path(argv[1]); 
        ConfigReader cfg(in_file_path);

        cfg.Print();

        std::string src_dir_path = cfg.Get("InputDirectoryPath");

        const int32_t raw_width = cfg.GetInt("InputRawWidth"); 

        const int32_t raw_height = cfg.GetInt("InputRawHeight");

        const int32_t profiling_loops = cfg.GetInt("TestProfilingLoopCount");

        const int32_t anchor_idx = cfg.GetInt("InputAnchorIndex");

        const int num_raws = cfg.GetInt("InputNumOfRaws");

        std::vector<std::string> in_names = GetInputNames(cfg, num_raws);

        std::string out_dir = cfg.Get("OutputDirectoryPath");

        std::string out_origin_name = cfg.Get("OutputAnchorImageName");

        {
            std::cout << std::endl << "Starting Some Processing :" << std::endl;

            PROFILE_MULTIPLE_ITERATIONS("Some Processing", profiling_loops);
            
            // Main Fxn here

            std::cout << std::endl << "..End of Some Processing" << std::endl;
        }
    }
    catch(std::string& err)
    {
        std::cerr << err << std::endl;
        return -1;
    }
    return 0;
}

