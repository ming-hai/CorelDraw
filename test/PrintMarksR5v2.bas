Attribute VB_Name = "PrintMarksR5v2"
Public Sub PrintMarksR5v2(sColorBar As Shape)
    
    Dim itemColorBar As Shape
    Dim colorBar As New ShapeRange, finalColorBar As New ShapeRange, srD As New ShapeRange
    Dim leftOffsetMark As New ShapeRange
    Dim rightOffsetMark As New ShapeRange
    Dim leftTargetMark As New ShapeRange
    Dim rightTargetMark As New ShapeRange
    Dim leftMark As New ShapeRange
    Dim signCmyk As New ShapeRange
    Dim printMarksPath As String
    Dim offsetLeftMark As Integer, offsetTargetMark As Integer
    Dim allMarks As New ShapeRange
    
    printMarksPath = (UserDataPath & "printMarks\")
    offsetLeftMark = 55
    offsetTargetMark = 15
    
    colorBar.Add sColorBar
    ActiveLayer.Import (printMarksPath & "leftOffsetMark.cdr")
    Set leftOffsetMark = ActiveSelectionRange
    ActiveLayer.Import (printMarksPath & "rightOffsetMark.cdr")
    Set rightOffsetMark = ActiveSelectionRange
    ActiveLayer.Import (printMarksPath & "targetMark.cdr")
    Set leftTargetMark = ActiveSelectionRange
    Set rightTargetMark = leftTargetMark.Duplicate
    ActiveLayer.Import (printMarksPath & "leftMark.cdr")
    Set leftMark = ActiveSelectionRange
    ActiveLayer.Import (printMarksPath & "signCmyk.cdr")
    Set signCmyk = ActiveSelectionRange
    Set finalColorBar = New ShapeRange
    
    colorBar.CenterX = ActivePage.BoundingBox.CenterX
    colorBar.PositionY = ActivePage.BoundingBox.Bottom + colorBar.BoundingBox.Height
    leftOffsetMark.PositionX = ActivePage.BoundingBox.Left
    leftOffsetMark.PositionY = ActivePage.BoundingBox.Top
    rightOffsetMark.PositionX = ActivePage.BoundingBox.Right - rightOffsetMark.BoundingBox.Width
    rightOffsetMark.PositionY = ActivePage.BoundingBox.Top
    leftMark.PositionX = ActivePage.BoundingBox.Left
    leftMark.PositionY = ActivePage.BoundingBox.Top - offsetLeftMark
    leftTargetMark.PositionX = ActivePage.BoundingBox.Left
    leftTargetMark.PositionY = ActivePage.BoundingBox.Bottom + offsetTargetMark
    rightTargetMark.PositionX = ActivePage.BoundingBox.Right - rightTargetMark.BoundingBox.Width
    rightTargetMark.PositionY = ActivePage.BoundingBox.Bottom + offsetTargetMark
    signCmyk.PositionX = leftTargetMark.BoundingBox.CenterX - signCmyk.BoundingBox.Width / 2
    signCmyk.PositionY = ActivePage.BoundingBox.Bottom + offsetTargetMark * 2
    
    colorBar.Ungroup
    For Each itemColorBar In colorBar
        If (itemColorBar.BoundingBox.Left > ActivePage.BoundingBox.Left) And (itemColorBar.BoundingBox.Right < ActivePage.BoundingBox.Right) Then
            finalColorBar.Add itemColorBar
        End If
    Next itemColorBar
    Set srD = finalColorBar.Duplicate
    colorBar.Delete
    
    Set itemColorBar = srD.Group
    itemColorBar.AddToSelection
    leftOffsetMark.AddToSelection
    rightOffsetMark.AddToSelection
    leftMark.AddToSelection
    leftTargetMark.AddToSelection
    rightTargetMark.AddToSelection
    signCmyk.AddToSelection
    ActiveSelectionRange.Group
End Sub

