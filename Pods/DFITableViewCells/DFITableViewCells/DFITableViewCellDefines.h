//
//  DFITableViewCellDefines.h
//  DFInfrastructure
//
//  Created by SDH on 2/5/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#ifndef DFITableViewCellDefines_h
#define DFITableViewCellDefines_h

#define CELL_OPTION_IS_FONT(font)   \
    [font isKindOfClass:[UIFont class]] ? font : nil
#define CELL_OPTION_IS_COLOR(color) \
    [color isKindOfClass:[UIColor class]] ? color : nil
#define CELL_OPTION_IS_TEXT(text)   \
    [text isKindOfClass:[NSString class]] ? text : nil

#endif /* DFITableViewCellDefines_h */


