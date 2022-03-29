
# Section: view
BEGIN {
    ctrl_help_item_put("ARROW UP/DOWN/LEFT/ROW", "to move focus")
    ctrl_help_item_put("ENTER", "for enter")
}

function view(      _component_help, _component_tag, _component_select, _component_preview){
    # view_calcuate_geoinfo()

    _component_help         = view_help()
    _component_tag          = view_tag()
    _component_select       = view_select()
    _component_preview      = view_preview()

    send_update( _component_help "\n" _component_tag "\n\n" _component_select "\n" _component_preview  )
}

function view_help(){
    return sprintf("%s", th_help_text( ctrl_help_get() ) )
}

function view_tag(         _cur_tag_idx, i, _tag, _data, _SELECTED_ITEM_STYLE ){
    _cur_tag_idx = ctrl_rstate_get(SELECTED_THEME_TAG_IDX)
    for (i=1; i<=THEME_TAG_L; i++){
        _tag = THEME_TAG[i]
        if (ctrl_sw_get( IS_FOCUS_TAG ) == true) _SELECTED_ITEM_STYLE = TH_THEME_PREVIEW_FOCUSE
        if ( _cur_tag_idx == i) _tag = th(_SELECTED_ITEM_STYLE UI_TEXT_REV, _tag)
        _data = _data " " _tag
    }
    return _data
}

# Using grid select
function view_select(       _cur_tag_idx, _cur_tag, _data, _selected_theme_idx, _SELECTED_ITEM_STYLE, page_index, page_begin, i, j, _iter_item_idx, _data_item_idx , _item_text ){
    _cur_tag_idx = ctrl_rstate_get(SELECTED_THEME_TAG_IDX)
    _cur_tag     = THEME_TAG[ _cur_tag_idx ]
    if (model_len == 0){
        _data = "We couldn’t find any data ..."
        _data = str_pad_left(_data, int(max_col_size/2), int(length(_data)/2))
        return th(TH_TABLE_UINFIND, _data)
    }
    view_page_item_num  = view_body_col_num * 3
    view_page_num       = int( ( model_len - 1 ) / view_page_item_num ) + 1
    _selected_theme_idx  = ctrl_rstate_get( SELECTED_THEME_IDX )
    page_index = int( (_selected_item_idx - 1) / view_page_item_num ) + 1
    page_begin = int( (page_index - 1) * view_page_item_num)
    view_body_row_num = int( model_len - 1 ) / view_body_col_num + 1
    if ( view_body_row_num > 3 ) view_body_row_num = 3
    for (i=0; i<view_body_row_num; i++) {
        for (j=1; j<=view_body_col_num; j++) {
            _iter_item_idx = page_begin + j + ( i * view_body_col_num )
            if (_iter_item_idx > model_len) break
            _data_item_idx = THEME_TAG_ITEM[ _cur_tag _iter_item_idx ]
            _item_text = str_pad_right( _data_item_idx, max_theme_len, THEME_TAG_ITEM[ _data_item_idx L ] )
            if (ctrl_sw_get( IS_FOCUS_TAG ) == false) _SELECTED_ITEM_STYLE = TH_THEME_PREVIEW_FOCUSE
            if (_selected_theme_idx == _iter_item_idx) _item_text = th( _SELECTED_ITEM_STYLE TH_THEME_PREVIEW_SELECT, _item_text)
            _data = _data "    "  _item_text
        }
        _data = _data "\n"
    }
    _data = _data "\n" ui_str_rep("-", max_col_size)
    return _data
}

function view_preview(             _selected_theme_idx, cur_theme){
    if (model_len == 0) return
    _selected_theme_idx = ctrl_rstate_get( SELECTED_THEME_IDX )
    cur_theme = THEME_ARR[ _selected_theme_idx ]
    return PREVIEW[cur_theme]
}

# EndSection

# Section: ctrl
function get_view_body_row_size() {
    VIEW_BODY_ROW_SIZE = max_row_size - PREVIEW_ROW_LINE
}

function ctrl(char_type, char_value,        _selected, _selected_keypath ){
    exit_if_detected( char_value, ",q," )


    if (char_value == "h")                           return ctrl_help_toggle()
    if (ctrl_sw_get( IS_FOCUS_TAG ) == true) {
        if (char_value == "LEFT")                    return ctrl_rstate_dec( SELECTED_THEME_TAG_IDX )
        if (char_value == "RIGHT")                   return ctrl_rstate_inc( SELECTED_THEME_TAG_IDX )
        if (char_value == "DN")                      return ctrl_sw_toggle( IS_FOCUS_TAG )
    } else {
        if (char_value == "LEFT")                    return ctrl_rstate_dec( SELECTED_THEME_IDX )
        if (char_value == "RIGHT")                   return ctrl_rstate_inc( SELECTED_THEME_IDX )
        if (char_value == "DN" )                     return ctrl_rstate_add( SELECTED_THEME_IDX, + view_body_col_num )
        if (char_value == "UP") {
            if (ctrl_rstate_get( SELECTED_THEME_IDX ) <= view_body_col_num) return ctrl_sw_toggle( IS_FOCUS_TAG )
            return ctrl_state_add( SELECTED_THEME_IDX, - view_body_col_num )
        }
        if (char_value == "ENTER" )                    return exit_with_elegant( char_value )
    }
}

# EndSection

# Section: model
function model_generate(    _filter,    i, l){
    _cur_tag_idx = ctrl_rstate_get(SELECTED_THEME_TAG_IDX)
    _cur_tag     = THEME_TAG[ _cur_tag_idx ]
    model_len    = THEME_TAG_ITEM[ _cur_tag L ]
    # for (i=1; i<=THEME_ARR_L; i++) {
    #     if (THEME_ARR[i] = )
    #     model[i] =
    # }
    ctrl_rstate_init( SELECTED_THEME_IDX, 1, model_len )
}
# EndSection

# Section: cmd
BEGIN{
    THEME_ARR_L = 0
    PREVIEW_ARR_L = 0
    # THEME_TAR_PATH = "../xcmd/theme/dist/theme.tgz"
    THEME_TAR_PATH = "~/.x-cmd/.tmp/theme/theme.tgz"
}


function get_theme_arr(         _cmd, i, _theme, _line, _len, _max_len){
    # tar -t style/ -f theme.tgz
    _cmd = "tar -f " THEME_TAR_PATH " -t style/"
    for (i=1; _cmd | getline _line; i++) {
        _theme = substr(_line, 7)
        if ( _theme == "" ) continue
        THEME_ARR[ ++THEME_ARR_L ] = _theme
        _len = length(_theme)
        if ( _max_len < _len ) _max_len = _len
    }
    THEME_ARR[ L ] = _max_len
    view_body_col_num = int(max_col_size / (_max_len + 4))
}

function get_theme_tag(         _cmd, i, _tag, _line, _theme){
    _cmd = "tar -f " THEME_TAR_PATH " -O -x index.yml"
    while ( _cmd | getline _line) {
        if ( _line ~ /^-/ ) {
            THEME_TAG_ITEM[ _tag L ] = i
            i=0
            _tag = substr(_line, 3)
            THEME_TAG[ ++THEME_TAG_L ] = _tag
        } else {
            _theme = substr(_line, 5)
            _theme_len = length(_theme)
            ++i
            THEME_TAG_ITEM[ _tag i ] = _theme
            THEME_TAG_ITEM[ _theme L ] = _len
            if ( max_theme_len < _theme_len ) max_theme_len = _theme_len
        }
    }
    ctrl_rstate_init( SELECTED_THEME_TAG_IDX, 1, THEME_TAG_L )
}

function get_theme_preview( theme,          _cmd, i, c, _ROW_LINE, _line){
    if (theme == "") return
    c = PREVIEW[theme]
    if ( c == "" ) {
        _cmd = "tar -f " THEME_TAR_PATH " -O -x style-preview/" theme
        c = "theme: " theme
        for (i=1; _cmd | getline _line; i++) {
            if (_line == "") continue
            c = c "\n" _line
            ++_ROW_LINE
        }
        PREVIEW[theme] = c
    }
    if (PREVIEW_ROW_LINE < _ROW_LINE) PREVIEW_ROW_LINE = _ROW_LINE
    # return c
}
# EndSection

# Section: cmd source

NR==1{
    try_update_width_height( $0 )
    get_theme_arr()
    get_theme_tag()
    model_generate()
    ctrl_sw_init( IS_FOCUS_TAG, true )
    get_theme_preview( THEME_ARR[1] )
    view()
}

NR>1{
    if ( try_update_width_height( $0 ) )    next
    # TODO: if it is update, recalculate the view.

    _cmd=$0
    gsub(/^C:/, "", _cmd)
    idx = index(_cmd, ":")
    ctrl(substr(_cmd, 1, idx-1), substr(_cmd, idx+1))
    if (ctrl_sw_get( IS_FOCUS_TAG ) == true) model_generate()
    get_theme_preview(THEME_ARR[ ctrl_rstate_get( SELECTED_THEME_IDX ) ])
    view()
}
# EndSection


END {
    if ( exit_is_with_cmd() == true ) {
        _selected_theme_idx = ctrl_rstate_get( SELECTED_THEME_IDX )
        cur_theme = THEME_ARR[ _selected_theme_idx ]
        send_env( "___X_CMD_THEME_FINAL_COMMAND",    exit_get_cmd() )
        send_env( "___X_CMD_THEME_APP_FINAL_NAME",  cur_theme )
    }
}
