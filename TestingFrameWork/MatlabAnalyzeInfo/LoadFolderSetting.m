function ret = LoadFolderSetting(select)
  switch lower(select)
        case '1610-001-mannique'
            ret.src_folder = '../../SourceImages/PD1610/001_MannequinFace/';
            ret.src_img_name = 'IMG_20170301_163227.jpg';
            ret.src_raw_name = 'pdaf_input_lens_pos_700.raw';
            ret.dst_folder = '../../ProcessedResults/PD1610/001_MannequinFace/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '24'; 
        case '1710-001-the-guy'
            ret.src_folder = '../../SourceImages/PD1710/001_TheGuy/';
            ret.src_img_name = 'outdoor_complex_001_2PD.bmp';
            ret.src_raw_name = '[Simul7.0]outdoor_complex_001_2PD.raw';
            ret.dst_folder = '../../ProcessedResults/PD1710/001_TheGuy/';
            ret.src_mask_name = 'outdoor_complex_001_2PD_mask.jpg';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
        case '1709-001-palm-open'
            ret.src_folder = '../../SourceImages/PD1709/001_PalmOpening/';
            ret.src_img_name = 'outdoor_complexBG_five_70_2PD.bmp';
            ret.src_raw_name = 'outdoor_complexBG_five_70_2PD.raw';
            ret.preview_yuv_name = 'outdoor_complexBG_five_70_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/001_PalmOpening/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-002-two-faces'
            ret.src_folder = '../../SourceImages/PD1709/002_TwoFaces/';
            ret.src_img_name = 'indoor_30_50_2PD.bmp';
            ret.src_raw_name = 'indoor_30_50_2PD.raw';
            ret.preview_yuv_name = 'indoor_30_50_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/002_TwoFaces/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-003-holding-toy'
            ret.src_folder = '../../SourceImages/PD1709/003_HoldingToy/';
            ret.src_img_name = 'indoor_complexBG_003_2PD.bmp';
            ret.src_raw_name = 'indoor_complexBG_003_2PD.raw';
            ret.preview_yuv_name = 'indoor_complexBG_003_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/003_HoldingToy/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-004-holding-doll'
            ret.src_folder = '../../SourceImages/PD1709/004_HoldingDoll/';
            ret.src_img_name = 'indoor_complexBG_002_2PD.bmp';
            ret.src_raw_name = 'indoor_complexBG_002_2PD.raw';
            ret.preview_yuv_name = 'indoor_complexBG_002_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/004_HoldingDoll/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-005-v-gesture'
            ret.src_folder = '../../SourceImages/PD1709/005_VGesture/';
            ret.src_img_name = 'outdoor_complexBG_vSign_70_2PD.bmp';
            ret.src_raw_name = 'outdoor_complexBG_vSign_70_2PD.raw';
            ret.preview_yuv_name = 'outdoor_complexBG_vSign_70_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/005_VGesture/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-006-fist-far'
            ret.src_folder = '../../SourceImages/PD1709/006_FistFar/';
            ret.src_img_name = 'outdoor_complexBG_fist_70_2PD.bmp';
            ret.src_raw_name = 'outdoor_complexBG_fist_70_2PD.raw';
            ret.preview_yuv_name = 'outdoor_complexBG_fist_70_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/006_FistFar/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-007-fist-near'
            ret.src_folder = '../../SourceImages/PD1709/007_FistNear/';
            ret.src_img_name = 'outdoor_complexBG_fist_30_2PD.bmp';
            ret.src_raw_name = 'outdoor_complexBG_fist_30_2PD.raw';
            ret.preview_yuv_name = 'outdoor_complexBG_fist_30_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/007_FistNear/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1610-jake-30cm'
            ret.src_folder = '../../SourceImages/PD1610/002_Jake30/';
            ret.src_img_name = 'pdaf_input_lens_pos_704_left.jpg';
            ret.src_raw_name = 'pdaf_input_lens_pos_704.raw';
            ret.preview_yuv_name = 'pdaf_input_lens_pos_704.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1610/002_Jake30/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '24'; 
      case '1610-hh-15cm'
            ret.src_folder = '../../SourceImages/PD1610/003_HH15/';
            ret.src_img_name = 'pdaf_input_lens_pos_447_left.jpg';
            ret.src_raw_name = 'pdaf_input_lens_pos_447.raw';
            ret.preview_yuv_name = 'pdaf_input_lens_pos_447.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1610/003_HH15/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '24'; 
      case '1709-rear-001-conference'
            ret.src_folder = '../../SourceImages/PD1709Rear/001_ConferenceRoom/';
            ret.src_img_name = '201707010901560s_4032x3024_780.bmp';
            ret.src_raw_name = '201707010901561r_4032x3024_780.raw';
            ret.dst_folder = '../../ProcessedResults/PD1709REAR/001_ConferenceRoom/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1709-008-outside-two-faces'
            ret.src_folder = '../../SourceImages/PD1709/008_OutsideTwoFaces/';
            ret.src_img_name = 'outdoor_30_30_2PD.bmp';
            ret.src_raw_name = 'outdoor_30_30_2PD.raw';
            ret.preview_yuv_name = 'outdoor_30_30_2PD.yuv';
            ret.dst_folder = '../../ProcessedResults/PD1709/008_OutsideTwoFaces/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '6'; 
      case '1610-macadamia'
            ret.src_folder = '../../SourceImages/PD1610/004_Macadamias/';
            ret.src_img_name = 'IMG_20180118_163907.jpg';
            ret.src_raw_name = 'pdaf_input__undefined_time__0.raw';
            ret.preview_yuv_name = 'pdaf_input__undefined_time__0.yuv';
            ret.dst_folder =  '../../ProcessedResults/PD1610/004_Macadamias/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '24';           
            ret.lens_macro_loc = '0';
            ret.lens_infinity_loc = '900';
            ret.lens_current_loc = '380';
      case '1610-jake-in-office'
            ret.src_folder = '../../SourceImages/PD1610/005_JakeInOffice/';
            ret.src_img_name = 'IMG_20180119_152641.jpg';
            ret.src_raw_name = 'pdaf_input__undefined_time__0.raw';
            ret.preview_yuv_name = 'pdaf_input__undefined_time__0.yuv';
            ret.dst_folder =  '../../ProcessedResults/PD1610/005_JakeInOffice/';
            ret.debug_folder = '../../ProcessedResults/tmp/';
            ret.max_search_range = '24';           
            ret.lens_macro_loc = '0';
            ret.lens_infinity_loc = '900';
            ret.lens_current_loc = '450';

  end
  
end