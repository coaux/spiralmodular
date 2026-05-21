
defobject(SpiralGUI
    SpiralGUI.C
)

defobject(Fl_Canvas
    Fl_Canvas.C
)

defobject(Fl_CommentGUI
    Fl_CommentGUI.C PawfalInput.C
)
target_link_libraries(Fl_CommentGUI PUBLIC
    Fl_DragBar
)

defobject(Fl_DeviceGUI
    Fl_DeviceGUI.C Fl_DragBar.cxx
)

defobject(Fl_DragBar
    Fl_DragBar.cxx
)

defobject(PawfalInput
    PawfalInput.C
)

defobject(PawfalYesNo
    PawfalYesNo.C
)

target_sources(SpiralGUI PUBLIC
    FILE_SET spiralGUI_HEADERS
    TYPE HEADERS
    BASE_DIRS
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    FILES
        SpiralGUI.H
        Fl_Canvas.h
)
