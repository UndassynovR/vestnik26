Sub ExportGraphsToPowerPoint()
    Dim shape As InlineShape
    Dim shp As Shape
    Dim imgCounter As Integer
    Dim filePath As String
    Dim exportFolder As String
    Dim pptApp As Object
    Dim pptPresentation As Object
    Dim pptSlide As Object
    Dim exportWidth As Long
    Dim exportHeight As Long
    
    ' Set the export folder for images
    exportFolder = Environ("USERPROFILE") & "\Desktop\ExportedImages\" ' Change as needed
    
    ' Create the folder if it doesn't exist
    If Dir(exportFolder, vbDirectory) = "" Then
        MkDir exportFolder
    End If
    
    ' Create PowerPoint application and presentation
    Set pptApp = CreateObject("PowerPoint.Application")
    Set pptPresentation = pptApp.Presentations.Add
    pptApp.Visible = True
    
    ' Initialize image counter
    imgCounter = 1
    
    ' Set export dimensions for better quality (e.g., 3840x2160 for 4K)
    exportWidth = 3840  ' Set the width as needed
    exportHeight = 2160 ' Set the height as needed
    
    ' Loop through all InlineShapes (such as charts) in the Word document
    For Each shape In ActiveDocument.InlineShapes
        If shape.Type = wdInlineShapeChart Or shape.Type = wdInlineShapeEmbeddedOLEObject Then
            ' Copy the InlineShape
            shape.Select
            Selection.Copy
            
            ' Add a new slide to PowerPoint
            Set pptSlide = pptPresentation.Slides.Add(imgCounter, 1) ' 1 for blank slide layout
            pptSlide.Shapes.Paste
            
            ' Export the slide as a PNG image with specified dimensions
            filePath = exportFolder & "Graph_" & imgCounter & ".png"
            pptSlide.Export filePath, "PNG", exportWidth, exportHeight
            imgCounter = imgCounter + 1
        End If
    Next shape
    
    ' Loop through all Shapes (e.g., floating charts) in the document
    For Each shp In ActiveDocument.Shapes
        If shp.Type = msoChart Or shp.Type = msoEmbeddedOLEObject Then
            ' Copy the Shape
            shp.Select
            Selection.Copy
            
            ' Add a new slide to PowerPoint
            Set pptSlide = pptPresentation.Slides.Add(imgCounter, 1) ' 1 for blank slide layout
            pptSlide.Shapes.Paste
            
            ' Export the slide as a PNG image with specified dimensions
            filePath = exportFolder & "Graph_" & imgCounter & ".png"
            pptSlide.Export filePath, "PNG", exportWidth, exportHeight
            imgCounter = imgCounter + 1
        End If
    Next shp
    
    ' Clean up PowerPoint
    pptPresentation.Close
    pptApp.Quit
    Set pptApp = Nothing

    MsgBox "Exported " & imgCounter - 1 & " graphs to " & exportFolder
End Sub
