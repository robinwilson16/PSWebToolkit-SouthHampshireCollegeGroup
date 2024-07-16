Imports CompassCC.ProSolution.PSWebEnrolmentKit
Imports CompassCC.CCCSystem.CCCCommon

Partial Class checkout_bursary
    Inherits CheckoutBaseControl
    Public ReadOnly Property RefNo() As String
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("RefNo")) Then
                Return ""
            Else
                Return CStr(Me.Page.Request("RefNo"))
            End If
        End Get
    End Property

    Private Property _lastAttachmentID() As Integer
        Get
            Return CInt(HttpContext.Current.Session("LastAttachmentID"))
        End Get
        Set(ByVal value As Integer)
            HttpContext.Current.Session("LastAttachmentID") = value
        End Set
    End Property

    Public ReadOnly Property OfferingID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("OfferingID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("OfferingID"))
            End If
        End Get
    End Property
    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)

        If Len(RefNo) > 0 Then

            Reference.Value = RefNo
            Reference.IsReadOnly = True

        Else

            Reference.Visible = False
        End If

        Dim intOfferingID As Integer = Me.OfferingID
        If intOfferingID <> -1 Then

            Dim tblOffering As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering.AcademicYearIDColumn, tblOffering.WebSiteAvailabilityIDColumn, tblOffering.CourseInformationIDColumn, tblOffering.TotalFeeAmountColumn, tblOffering.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, intOfferingID)
            tblOffering.TableAdapter.Load(tblOffering, v)


            If tblOffering.Count > 0 AndAlso tblOffering(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering(0)

                    AcYr.InnerText = .AcademicYearID
                    item.Cost = 0

                    item.Description = .GetRowDescription
                    item.ItemType = "Application"
                    item.OfferingID = .OfferingID.Value
                    item.CourseInfoID = .CourseInformationID.GetValueOrDefault

                End With
                With WorkingData.ShoppingCart
                    If Not .Items.Contains(item) Then
                        .Items.Add(item)
                    End If
                End With
            End If
        End If
        Session("RequestMode") = RequestMode.ApplicationRequest

        If Not IsPostBack Then


            PopulateOfferingFeeTable()


        Else

            CheckAge()
            If Not childcaresupport.SelectedValue = "" Then

                If childcaresupport.SelectedValue = "1" Then

                    Childcare.Visible = True

                Else

                    Childcare.Visible = False

                End If


                If u19hide.Visible = True Then

                    ChildName.IsRequired = True
                    ChildHours.IsRequired = True
                    ProvName.IsRequired = True


                End If
                ' Insert the table of offerings


            End If


        End If

        If Not IsPostBack Then
            loadAttachments()
        End If
    End Sub


    Private Sub CheckAge()



        If Not datepicker.Value = "" Then

            If DateDiff(DateInterval.Day, datepicker.Value, Now) < (19 * 365) Then

                'under 19

                u19hide.Visible = True

            Else


                u19hide.Visible = False


            End If

        Else

            u19hide.Visible = False

        End If


    End Sub


    Protected Sub PopulateOfferingFeeTable()
        'Load all offerings in the shopping basket
        Dim stb As New Text.StringBuilder
        For Each item As ShoppingCartItem In WorkingData.ShoppingCart.Items
            If stb.Length > 0 Then stb.Append(",")
            stb.Append(item.OfferingID)
        Next
        If stb.Length > 0 Then
            'Load offerings
            Dim tblOffering As New OfferingDataTable
            Dim vOffering As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataViewDefault(tblOffering)
            vOffering.Columns.AddPKColumns()
            vOffering.Columns.EnsureColumnsAreSelected(True, False, tblOffering.CodeColumn, tblOffering.StartTimeColumn, tblOffering.DayOfWeekColumn, tblOffering.StartDateColumn, tblOffering.EndDateColumn, tblOffering.SiteDescriptionColumn, tblOffering.EndTimeColumn)
            vOffering.Columns.EnsureColumnIsSelected(False, False, tblOffering.KISCourseCodeColumn)

            vOffering.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, stb.ToString, FilterOperator.OperatorInList)

            tblOffering.TableAdapter.Load(tblOffering, vOffering)

            Me.GridView1.DataSource = tblOffering
            Me.GridView1.DataBind()
            Me.GridView1.Visible = True
        End If
    End Sub
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then


            Dim OfferingID As Integer = DataBinder.Eval(e.Row.DataItem, "OfferingID")
            ' Dim CourseOfferingFees As New CourseOfferingFees(OfferingID)

        End If
    End Sub


    Public Property intCurrentEmploymentRecords() As Integer
        Get
            Return CInt(HttpContext.Current.Session("intEmploymentRows"))
        End Get
        Set(ByVal value As Integer)
            HttpContext.Current.Session("intEmploymentRows") = value
        End Set
    End Property

    Public Overrides Sub ValidateControl()

        If Not chkConfirm.Checked Then
            Dim v As New CustomValidator()
            v.ErrorMessage = "Please confirm that you have read the declaration above."
            v.IsValid = False
            Me.Page.Validators.Add(v)

            Me.ValidationSummary1.ShowSummary = True
        End If


        If trNoItems.Visible = True Then
            Dim v As New CustomValidator()
            v.ErrorMessage = "Please upload evidence"
            v.IsValid = False
            Me.Page.Validators.Add(v)

            Me.ValidationSummary1.ShowSummary = True
        End If

        If childcaresupport.SelectedValue = "" Then
            Dim v As New CustomValidator()
            v.ErrorMessage = "Would you like to apply for childcare support?"
            v.IsValid = False
            Me.Page.Validators.Add(v)


        End If

        If Childcare.Visible = True Then

            If ChildName.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the Child's name"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If

            If ChildHours.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Do you receive free government funded hours"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If
            If ProvName.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter Name of Childcare Provider (Nursery/Child Minder)"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If

            If DOC.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter DOB of the child"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If

            If empad1.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the address of the Childcare Provider (Nursery/Child Minder)"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If

            If employerpostcode.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the postcode of the Childcare Provider (Nursery/Child Minder)"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If
            If provEm.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the chilcare provider email"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If
            If provTel.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the chilcare provider phone"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If
            If Ofsted.Value = "" Then
                Dim v As New CustomValidator()
                v.ErrorMessage = "Please enter the chilcare provider Ofsted Number"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If




        End If

        If u19hide.Visible = True AndAlso fldVun.Value = "" Then

            Dim v As New CustomValidator()
            v.ErrorMessage = "Please select which category applies to you (Vulnerable Bursary)"
            v.IsValid = False
            Me.Page.Validators.Add(v)


        End If

        If u19hide.Visible = True AndAlso fldMeals.Value = "" Then

            Dim v As New CustomValidator()
            v.ErrorMessage = "Are your Parent(s) Guardian or Partner in receipt of any of the following?"
            v.IsValid = False
            Me.Page.Validators.Add(v)


        End If


        If Not datepicker.Value = "" Then

            If DateDiff(DateInterval.Day, CDate(datepicker.Value), Now) < ((16 * 365) - 60 ) Then

                Dim v As New CustomValidator
                v.IsValid = False
                v.ErrorMessage = "Please check your date of birth - you must be over 16 when the course begins"
                Me.Page.Validators.Add(v)



            End If

        Else


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please enter your date of birth"
            Me.Page.Validators.Add(v)


        End If

        If Sex.SelectedValue = "" Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please select your Gender at birth"
            Me.Page.Validators.Add(v)


        End If

        If travelQ.SelectedValue = "" Then

            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "how are you travelling to college?"
            Me.Page.Validators.Add(v)

        End If

    End Sub

    Protected Sub rptAttachments_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If (e.CommandName = "RemoveAttachment") Then
            Dim attachmentID = CCCDataTypeConverter.Convert(Of Integer)(e.CommandArgument)
            Dim rowToDelete = WorkingData.EnrolmentRequestAttachments.FindByAttachmentID(attachmentID)
            If (rowToDelete IsNot Nothing) Then
                WorkingData.EnrolmentRequestAttachments.RemoveRow(rowToDelete)
                loadAttachments()
            End If
        End If
    End Sub
    'Public Function GetRandom(ByVal Min As Integer, ByVal Max As Integer) As Integer
    '    'function to append random int to Caption Evidence for IX constraint error
    '    Static Generator As System.Random = New System.Random()
    '    Return Generator.Next(Min, Max)
    'End Function



    Private Sub btnUpload_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        '   trNoItems.Visible = False
        'Me.Page.Validate()
        ''Following line is important to perform validations on File Upload control based on setup done on control.
        Me.fuAttachment.ValidateFile()

        'If Not Me.Page.IsValid Then
        '    Return
        'End If

        Dim rowAttachment = WorkingData.EnrolmentRequestAttachments.NewRow
        _lastAttachmentID -= 1
        With rowAttachment
            .AttachmentID = _lastAttachmentID
            .TypeOfEvidence = ddlTypeOfEvidence.SelectedValue & System.DateTime.Now
            .Notes = txtNotes.Text.Trim
            .Attachment = fuAttachment.FileBytes
            .FileName = fuAttachment.FileName
            .Size = fuAttachment.FileBytes.Length
            If CCCAttachmentThumbnailGenerator.FilenameIndicatesFileIsCompatibleImage(fuAttachment.FileName) Then
                Try
                    .ImageThumb = CCCAttachmentThumbnailGenerator.CreateThumbnailAsByteArray(.Attachment, 96)
                Catch ex As Exception
                    ' Cannot create thumb nail- ignore error
                    .ImageThumb = Nothing ' No thumb-nail
                End Try
            End If
            .CreatedDate = DateTime.Now
        End With
        WorkingData.EnrolmentRequestAttachments.AddRow(rowAttachment)
        ''Redirecting to self instead of just resetting controls to avoid issue of attachment being added on browser refresh.
        ' Response.Redirect(GetResourceValue("checkout_bursary_aspx"))
        loadAttachments()
        'txtNotes.Text = Nothing
        ddlTypeOfEvidence.SelectedIndex = 0
    End Sub

    Private Sub btnContinue_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnContinue.Click


        Me.Page.Validate()

        If Me.Page.IsValid Then

            If Not Sex.SelectedValue = "" Then

                WorkingData.ApplicationRequestRow.Sex = Sex.SelectedValue

            End If


            If Not travelQ.SelectedValue = "" Then

                Dim StrTravel As String = String.Empty
                For Each item As ListItem In travelQ.Items

                    If item.Selected Then

                        StrTravel = StrTravel & ", " & item.Text
                    End If
                Next

                WorkingData.ApplicationRequestRow.ApplicationUserDefined13 = StrTravel
            End If

            WorkingData.ApplicationRequestRow.ApplicationType = "DLSFAPP"

            WorkingData.ApplicationRequestRow.ApplicationTypeID = 9

            If Not Len(DOC.Value) = 0 Then

                WorkingData.ApplicationRequestRow.ApplicationUserDefined17 = CStr(DOC.Value)
            End If

            Dim StrAll As String = ("Provider Name : " & ProvName.Value & vbCrLf & empad1.Value & vbCrLf & empad2.Value & vbCrLf & empad3.Value & vbCrLf & empad4.Value & vbCrLf & employerpostcode.Value & vbCrLf & "OFSTED REG: " & Ofsted.Value & vbCrLf & "Tel: " & provTel.Value & vbCrLf & "Email: " & provEm.Value)
            Dim Strtrim As String = StrAll.Trim()
            ' Dim StrSub As String = Strtrim.Substring(0, 254)

            WorkingData.ApplicationRequestRow.ApplicationUserDefined20 = "Confirmed declaration on : " & Today.ToShortDateString()


            WorkingData.ApplicationRequestRow.Notes = StrAll


            Dim chkconfirm As Boolean = True

            'WorkingData.EnrolmentRequestRow.StudentDeclaration = chkconfirm

            Response.Redirect(GetResourceValue("checkout_makepayment_aspx"))

        End If

        'LSF Value for Other (UD21) WLW06

    End Sub

    Private Sub loadAttachments()
        rptAttachments.DataSource = WorkingData.EnrolmentRequestAttachments
        rptAttachments.DataBind()
        If (WorkingData.EnrolmentRequestAttachments.Rows.Count = 0) Then
            trNoItems.Visible = True
        Else
            trNoItems.Visible = False
        End If
    End Sub


End Class
