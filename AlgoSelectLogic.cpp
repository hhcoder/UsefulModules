#include <vector>
#include <stdint.h>

struct ConsumerSignature
{
    std::string name;
    int32_t id;
    std::vector< std::pair<int32_t, int32_t> > input_format; //data type, number of channels
    std::vector< std::pair<int32_t, int32_t> > output_format;
};

typedef ConsumerSignature AlgorithmSignature; //Algorithm is Consumer

typedef std::vector<AlgorithmSignature> AlgorithmMenu;

struct ProviderSignature
{
    std::string name;
    int32_t id;
    std::vector< std::pair<int32_t, int32_t> > output_format;
};

typedef std::vector<ProviderSignature> FlowMenu;

int RegisterComboMenu(const ComboMenu& in_table);
std::pair<int32_t, int32_t> ChooseCombo(const CameraCaptureStatus& in_cap_info);

int main(int argc, char* argv[])
{
    AlgorithmSignature llhdr{ 
        std::string("low-light HDR"), 
        GetUniqueID(), 
        {{BAYER_PATTERN_RGGB, 6}}, 
        {{BAYER_PATTERN_RGGB, 1}}
    };

    AlgorithmSignature raw_denoise{
        std::string("raw denoise"),
        GetUniqueID(),
        {{BAYER_PATTERN_RGGB, 6}, {BAYER_PATTERN_RGGB, 5}, {BAYER_PATTERN_RGGB, 4}, {BAYER_PATTERN_RGGB, 3}, {BAYER_PATTERN_RGGB, 2}},
        {{BAYER_PATTERN_RGGB, 1}}
    };

    AlgorithmSignature raw_super_resolution{
        std::string("raw super resolution"),
        GetUniqueID(),
        {{BAYER_PATTERN_RGGB, 6}},
        {{BAYER_PATTERN_RGGB, 1}}
    };

    AlgorithmSignature four_in_one_remosaic{
        std::string("4-in-1 remosaic"),
        GetUniqueID(),
        {{FOUR_IN_ONE_PATTERN_RGGB, 1}},
        {{BAYER_PATTERN_RGGB, 1}}
    };

    struct AlgorithmContainer;

    // Insert some way to attatch algorithms together (most likely K-node tree), called, combo
    // Also, give each combo a name and unique ID

    ProviderSignature past_bayer_frame_capture{
        std::string("capture past frames"),
        GetUniqueID(),
        {{BAYER_PATTERN_RGGB, 6}, {BAYER_PATTERN_RGGB, 5}, {BAYER_PATTERN_RGGB, 4}, {BAYER_PATTERN_RGGB, 3}, {BAYER_PATTERN_RGGB, 2}, {BAYER_PATTERN_RGGB, 1}}
    };

    ProviderSignature future_bayer_frame_capture{
        std::string("capture future frames"),
        GetUniqueID(),
        {{BAYER_PATTERN_RGGB, 6}, {BAYER_PATTERN_RGGB, 5}, {BAYER_PATTERN_RGGB, 4}, {BAYER_PATTERN_RGGB, 3}, {BAYER_PATTERN_RGGB, 2}, {BAYER_PATTERN_RGGB, 1}}
    };

    RegisterCombo(
        {{llhdr, past_bayer_frame_capture},
         {llhdr, future_bayer_frame_capture},
         {raw_denoise, past_bayer_frame_capture} }
    );

    InputInfo input_info = CollectSystemInfo();

    std::pair<int32_t, int32_t> combo_id = ChooseCombo(input_info);

    ExecuteFlow(combo_id.first);

    ExecuteAlgorithm(combo_id.second);

    return 0;
}


FlowInfo GetFlowDetailedInfo(const FlowID& in_id);

AlgorithmInfo GetAlgorithmInfo(const AlgorithmID& in_id);

InitPreProc(const AlgorithmPipeMenu& in_pipe)
{
}

PreProcChooseCombo(const AlgorithmPipeID& in_id)

PreProcRun()