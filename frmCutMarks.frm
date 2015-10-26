VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCutMarks 
   Caption         =   "Cut Marks v1.0"
   ClientHeight    =   5865
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   3150
   OleObjectBlob   =   "frmCutMarks.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmCutMarks"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub btnCancel_Click()
Unload Me
End Sub

Private Sub btnMake_Click()
    Application.ActiveDocument.Unit = cdrMillimeter
    Dim aSel As ShapeRange
    Dim countX As Integer
    Dim countY As Integer
    Dim selX As Double
    Dim selY As Double
    Dim selW As Double
    Dim selH As Double
    Dim markH As Integer
    Dim bleed As Integer
    Dim oneCut As Boolean
    Dim productW As Double
    Dim productH As Double
    
    countX = txtbCountX.Value
    countY = txtbCountY.Value
    markH = txtbMarkHeight.Value
    bleed = txtbOffset.Value
    oneCut = cbOneCut.Value
    
    Set aSel = ActiveSelectionRange
    If (aSel.Count > 0) Then
        selX = aSel.PositionX
        selW = aSel.SizeWidth
        selY = aSel.PositionY
        selH = aSel.SizeHeight
        productW = selW / countX
        productH = selH / countY
        If tbTop Then
            MakeMarkTop selX, selY, selW, selH, productW, productH, countX, countY, markH, bleed, oneCut
        End If
        If tbLeft Then
            MakeMarkLeft selX, selY, selW, selH, productW, productH, countX, countY, markH, bleed, oneCut
        End If
        If tbRight Then
            MakeMarkRight selX, selY, selW, selH, productW, productH, countX, countY, markH, bleed, oneCut
        End If
        If tbBottom Then
            MakeMarkBottom selX, selY, selW, selH, productW, productH, countX, countY, markH, bleed, oneCut
        End If
    End If
    
Unload Me
End Sub

Sub MakeMarkTop(selX As Double, selY As Double, selW As Double, selH As Double, productW As Double, productH As Double, countX As Integer, countY As Integer, markH As Integer, bleed As Integer, oneCut As Boolean)
    Dim startX As Double, startY As Double, endX As Double, endY As Double
    Dim markX As Double, markY As Double
    Dim mark As Shape
    Dim i As Integer
    
    'first mark
    startX = selX + bleed
    endX = selX + bleed
    startY = selY
    endY = selY + markH
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    'final mark
    startX = selX + selW - bleed
    endX = selX + selW - bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    
    If countX > 1 Then
        startX = selX
        For i = 1 To countX - 1
            startX = startX + productW
            If oneCut Then
                markX = startX
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            Else
                markX = startX - bleed
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
        
                markX = startX + bleed
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            End If
    Next i
    End If
End Sub

Sub MakeMarkLeft(selX As Double, selY As Double, selW As Double, selH As Double, productW As Double, productH As Double, countX As Integer, countY As Integer, markH As Integer, bleed As Integer, oneCut As Boolean)
    Dim startX As Double, startY As Double, endX As Double, endY As Double
    Dim markX As Double, markY As Double
    Dim mark As Shape
    Dim i As Integer
    
    'first mark
    startX = selX
    endX = selX - markH
    startY = selY - bleed
    endY = selY - bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    'final mark
    startY = selY - selH + bleed
    endY = selY - selH + bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    
    If countY > 1 Then
        startY = selY
        For i = 1 To countY - 1
            startY = startY - productH
            If oneCut Then
                markY = startY
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            Else
                markY = startY + bleed
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            
                markY = startY - bleed
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            End If
        Next i
    End If
End Sub

Sub MakeMarkRight(selX As Double, selY As Double, selW As Double, selH As Double, productW As Double, productH As Double, countX As Integer, countY As Integer, markH As Integer, bleed As Integer, oneCut As Boolean)
    Dim startX As Double, startY As Double, endX As Double, endY As Double
    Dim markX As Double, markY As Double
    Dim mark As Shape
    Dim i As Integer
    
    'first mark
    startX = selX + selW
    endX = selX + selW + markH
    startY = selY - bleed
    endY = selY - bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    'final mark
    startY = selY - selH + bleed
    endY = selY - selH + bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    
    If countY > 1 Then
        startY = selY
        For i = 1 To countY - 1
            startY = startY - productH
            If oneCut Then
                markY = startY
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            Else
                markY = startY + bleed
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            
                markY = startY - bleed
                Set mark = ActiveLayer.CreateLineSegment(startX, markY, endX, markY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            End If
        Next i
    End If
End Sub

Sub MakeMarkBottom(selX As Double, selY As Double, selW As Double, selH As Double, productW As Double, productH As Double, countX As Integer, countY As Integer, markH As Integer, bleed As Integer, oneCut As Boolean)
    Dim startX As Double, startY As Double, endX As Double, endY As Double
    Dim markX As Double, markY As Double
    Dim mark As Shape
    Dim i As Integer
    
    'first mark
    startX = selX + bleed
    endX = selX + bleed
    startY = selY - selH
    endY = selY - selH - markH
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    'final mark
    startX = selX + selW - bleed
    endX = selX + selW - bleed
    Set mark = ActiveLayer.CreateLineSegment(startX, startY, endX, endY)
    mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
    
    If countX > 1 Then
        startX = selX
        For i = 1 To countX - 1
            startX = startX + productW
            If oneCut Then
                markX = startX
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            Else
                markX = startX - bleed
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            
                markX = startX + bleed
                Set mark = ActiveLayer.CreateLineSegment(markX, startY, markX, endY)
                mark.Outline.SetProperties 0.0762, OutlineStyles(0), CreateRegistrationColor
            End If
        Next i
    End If
End Sub



