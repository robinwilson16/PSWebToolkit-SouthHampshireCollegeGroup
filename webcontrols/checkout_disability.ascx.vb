﻿Imports CompassCC.ProSolution.PSWebEnrolmentKit
Imports CompassCC.CCCSystem.CCCCommon

Partial Class checkout_disability
    Inherits CheckoutBaseControl


    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)

        'Breadcrumbs
        If WorkingData.ShoppingCart.ContainsItemsOfType("Application") AndAlso WorkingData.ShoppingCart.ContainsItemsOfType("Enrolment") Then
            breadcrumbenrols.Visible = True
            breadcrumbapps.Visible = False
        ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Application") Then
            breadcrumbenrols.Visible = False
            breadcrumbapps.Visible = True
        ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Enrolment") Then
            breadcrumbenrols.Visible = True
            breadcrumbapps.Visible = False
        ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Enquiry") Then
            breadcrumbenrols.Visible = False
            breadcrumbapps.Visible = False
        Else
            breadcrumbenrols.Visible = False
            breadcrumbapps.Visible = False
        End If

        'Custom code to colour the form based on the contents of the shopping basket
        'Use this when sharing pages between types (Application/Enrolment)

        'Clear class attributes first
        Me.panel1.Attributes("class") = ""



        If WorkingData.ShoppingCart.ContainsItemsOfType("Enrolment") Then
            Me.panel1.Attributes("class") = "panel panel-danger"
        ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Application") Then
            Me.panel1.Attributes("class") = "panel panel-success"
        ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Enquiry") Then
            Me.panel1.Attributes("class") = "panel panel-info"
        Else
            Me.panel1.Attributes("class") = "panel panel-danger"
        End If
    End Sub

    Protected Overrides Sub CreateChildControls()
        MyBase.CreateChildControls()

        'If IsPostBack Then

        'Recreate the header row
        Dim rowH As New TableRow

        Dim c1, c2 As New TableCell
        c1.Text = "Disability Category"
        c1.Attributes.Add("class", "text=center")
        c2.Text = "Primary"
        rowH.Cells.AddRange({c1, c2})

        tblDisability.Rows.Add(rowH)

        If IsPostBack Then
            Dim c As Control = GetPostBackControl(Me.Page)
            If c.GetType Is GetType(Button) Then
                Dim btn = DirectCast(c, Button)
                If btn.Text = "Add Row" Then
                    intCurrentDisability += 1
                ElseIf btn.ID = "btnNoDisability" Then
                    intCurrentDisability = 0
                    WorkingData.EnrolmentRequestDisabilityCategory.Clear()
                    slidingdiv.Visible = Not slidingdiv.Visible
                    If slidingdiv.Visible Then
                        btn.Text = "No prior disability"
                        btn.ToolTip = "Click to remove all the items listed below (And hide the list)"
                    Else
                        btn.Text = "Add prior disability"
                        btn.ToolTip = "Click to show a list below that you can add Qualifications to"
                    End If
                End If
            End If
        End If

        If slidingdiv.Visible Then

            For i = 0 To intCurrentDisability
                Dim row As New TableRow
                Dim cell1, cell2 As New TableCell
                Dim ctl1, ctl2 As New StudentDisabilityField


                ctl1.StudentDisabilityFieldType = StudentDisabilityFieldType.DisabilityCategoryID
                ctl1.StudentDisabilityRowNumber = i
                ctl1.LabelWidth = 0
                cell1.Controls.Add(ctl1)

                ctl2.StudentDisabilityFieldType = StudentDisabilityFieldType.IsPrimary
                ctl2.StudentDisabilityRowNumber = i
                ctl2.LabelWidth = 0
                cell2.Controls.Add(ctl2)

                row.Cells.AddRange({cell1, cell2})
                tblDisability.Rows.Add(row)

            Next
        End If
    End Sub

    Public Property intCurrentDisability() As Integer
        Get
            Return CInt(HttpContext.Current.Session("intDisabilityRows"))
        End Get
        Set(ByVal value As Integer)
            HttpContext.Current.Session("intDisabilityRows") = value
        End Set
    End Property


    Private Sub btnContinue_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnContinue.Click

        Me.Page.Validate()

        If Me.Page.IsValid Then
            If WorkingData.ShoppingCart.ContainsItemsOfType("Application") AndAlso WorkingData.ShoppingCart.ContainsItemsOfType("Enrolment") Then
                Response.Redirect(GetResourceValue("checkout_references_aspx"))
            ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Application") Then
                ''CCCPS-75837: Redirecting user to new Attachment step instead of data protection directly.
                Response.Redirect(GetResourceValue("checkout_attachments_aspx"))
            ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Enrolment") Then
                Response.Redirect(GetResourceValue("checkout_references_aspx"))
            ElseIf WorkingData.ShoppingCart.ContainsItemsOfType("Enquiry") Then
                Response.Redirect(GetResourceValue("checkout_dataprotection_enquiry"))
            End If
        End If
    End Sub


End Class
