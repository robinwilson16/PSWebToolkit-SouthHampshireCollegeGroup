Option Explicit Off
Option Strict Off
Imports System.Collections.Generic
Imports System.IO
Imports System.Linq
Imports CompassCC.CCCSystem.CCCCommon
Imports CompassCC.ProSolution.PSWebEnrolmentKit

Partial Class checkout_diversity
    Inherits webenrolmentcontrolvalidate

    Private ReadOnly Property AFD_SERVER As String
        Get
            Return SystemSettings.AFDEvolution_Server
        End Get
    End Property

    Private ReadOnly Property AFD_SERIAL_NUMBER As String
        Get
            Return SystemSettings.AFDEvolution_SerialNumber
        End Get
    End Property

    Private ReadOnly Property AFD_PASSWORD As String
        Get
            Return SystemSettings.AFDEvolution_Password
        End Get
    End Property

    Private ReadOnly Property AFD_USER_ID As String
        Get
            Return SystemSettings.AFDEvolution_UserID
        End Get
    End Property

    Private Enum SearchType
        FastFind
        Search
        Retrieve
    End Enum
    Public ReadOnly Property OfferingID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("OfferingID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("OfferingID"))
            End If
        End Get
    End Property
    Public ReadOnly Property Offering1ID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Offering1ID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("Offering1ID"))
            End If
        End Get
    End Property
    Public ReadOnly Property Offering2ID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Offering2ID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("Offering2ID"))
            End If
        End Get
    End Property
    Public ReadOnly Property Offering3ID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Offering3ID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("Offering3ID"))
            End If
        End Get
    End Property
    Public ReadOnly Property Offering4ID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Offering4ID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("Offering4ID"))
            End If
        End Get
    End Property
    Public ReadOnly Property Offering5ID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Offering5ID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("Offering5ID"))
            End If
        End Get
    End Property



    Public Shared Sub SortListControl(ByVal control As ListControl, ByVal isAscending As Boolean)
        Dim collection As List(Of ListItem)

        If isAscending Then
            collection = control.Items.Cast(Of ListItem)().[Select](Function(x) x).OrderBy(Function(x) x.Text).ToList()
        Else
            collection = control.Items.Cast(Of ListItem)().[Select](Function(x) x).OrderByDescending(Function(x) x.Text).ToList()
        End If

        control.Items.Clear()

        For Each item As ListItem In collection
            control.Items.Add(item)
        Next
    End Sub

    ''Load Page

    Protected Overrides Sub OnLoad(ByVal e As System.EventArgs)
        MyBase.OnLoad(e)



        'If WorkingData.ShoppingCart.Items.Count > 0 Then
        '    Dim stb As New StringBuilder
        '    For Each item In WorkingData.ShoppingCart.Items

        '        stb.Append(item.OfferingID.ToString + ",")

        '    Next
        '    WorkingData.EnrolmentRequestRow.ApplicationUserDefined29 = stb.ToString()
        'End If



        Session("RequestMode") = RequestMode.EnrolmentRequest


        If Not IsPostBack Then

            PutAllOfferingsInBasket()
            PopulateOfferingFeeTable()


        Else

        End If





    End Sub

    'Private Sub CheckcourseSpecificQuestions()


    '    Dim stb As New Text.StringBuilder
    '    For Each item As ShoppingCartItem In WorkingData.ShoppingCart.Items
    '        If stb.Length > 0 Then stb.Append(",")
    '        stb.Append(item.OfferingID)
    '    Next
    '    If stb.Length > 0 Then
    '        'Load offerings
    '        Dim tblOffering As New OfferingDataTable
    '        Dim vOffering As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataViewDefault(tblOffering)
    '        vOffering.Columns.AddPKColumns()
    '        vOffering.Columns.EnsureColumnsAreSelected(True, False, tblOffering.CodeColumn, tblOffering.UserDefined20Column, tblOffering.UserDefined21Column, tblOffering.UserDefined24Column, tblOffering.UserDefined22Column, tblOffering.UserDefined23Column, tblOffering.OfferingTypeColumn, tblOffering.StartTimeColumn, tblOffering.DayOfWeekColumn, tblOffering.StartDateColumn, tblOffering.EndDateColumn, tblOffering.SiteDescriptionColumn, tblOffering.EndTimeColumn, tblOffering.TotalFeeAmountColumn, tblOffering.SIDColumn, tblOffering.WebSiteAvailabilityIDColumn)
    '        vOffering.Columns.EnsureColumnIsSelected(False, False, tblOffering.KISCourseCodeColumn)

    '        vOffering.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, stb.ToString, FilterOperator.OperatorInList)

    '        tblOffering.TableAdapter.Load(tblOffering, vOffering)

    '        With tblOffering(0)

    '            If Not .UserDefined20 Is Nothing Then

    '                courseQs.Visible = True

    '                CQS1.CustomCaption = .UserDefined20
    '                CQS1.IsRequired = True
    '                CQS1.Visible = True


    '            End If

    '            If Not .UserDefined21 Is Nothing Then
    '                courseQs.Visible = True
    '                CQS2.CustomCaption = .UserDefined21
    '                CQS2.IsRequired = True
    '                CQS2.Visible = True


    '            End If

    '            If Not .UserDefined22 Is Nothing Then
    '                courseQs.Visible = True

    '                CQS3.CustomCaption = .UserDefined22
    '                CQS3.IsRequired = True
    '                CQS3.Visible = True


    '            End If

    '            If Not .UserDefined23 Is Nothing Then
    '                courseQs.Visible = True

    '                CQS4.CustomCaption = .UserDefined23
    '                CQS4.IsRequired = True
    '                CQS4.Visible = True


    '            End If


    '            If Not .UserDefined24 Is Nothing Then
    '                courseQs.Visible = True

    '                SpecificUpload.InnerText = .UserDefined24


    '            End If


    '        End With


    '    End If

    'End Sub

    ''Put offerings in basket
    Protected Sub PutAllOfferingsInBasket()

        Dim IntOffering1ID As Integer = Me.Offering1ID
        If IntOffering1ID <> -1 Then

            Dim tblOffering1 As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering1)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering1.WebSiteAvailabilityIDColumn, tblOffering1.CourseInformationIDColumn, tblOffering1.TotalFeeAmountColumn, tblOffering1.OfferingTypeIDColumn, tblOffering1.CollegeLevelUserDefined1Column)
            v.Filters.SetColumnFilter(tblOffering1.OfferingIDColumn, IntOffering1ID)
            tblOffering1.TableAdapter.Load(tblOffering1, v)

            If tblOffering1.Count > 0 AndAlso tblOffering1(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering1(0)


                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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

        Dim IntOffering2ID As Integer = Me.Offering2ID

        If IntOffering2ID <> -1 Then

            Dim tblOffering2 As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering2)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering2.WebSiteAvailabilityIDColumn, tblOffering2.CourseInformationIDColumn, tblOffering2.TotalFeeAmountColumn, tblOffering2.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering2.OfferingIDColumn, IntOffering2ID)
            tblOffering2.TableAdapter.Load(tblOffering2, v)



            If tblOffering2.Count > 0 AndAlso tblOffering2(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering2(0)

                    '  Dim CourseOfferingFees As New CourseOfferingFees(CType(.OfferingID, Integer))

                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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
        Dim IntOffering3ID As Integer = Me.Offering3ID

        If IntOffering3ID <> -1 Then

            Dim tblOffering3 As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering3)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering3.WebSiteAvailabilityIDColumn, tblOffering3.CourseInformationIDColumn, tblOffering3.TotalFeeAmountColumn, tblOffering3.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering3.OfferingIDColumn, IntOffering3ID)
            tblOffering3.TableAdapter.Load(tblOffering3, v)


            If tblOffering3.Count > 0 AndAlso tblOffering3(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering3(0)


                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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

        Dim IntOffering4ID As Integer = Me.Offering4ID

        If IntOffering4ID <> -1 Then

            Dim tblOffering4 As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering4)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering4.WebSiteAvailabilityIDColumn, tblOffering4.CourseInformationIDColumn, tblOffering4.TotalFeeAmountColumn, tblOffering4.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering4.OfferingIDColumn, IntOffering4ID)
            tblOffering4.TableAdapter.Load(tblOffering4, v)

            If tblOffering4.Count > 0 AndAlso tblOffering4(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering4(0)


                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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
        Dim IntOffering5ID As Integer = Me.Offering5ID

        If IntOffering5ID <> -1 Then

            Dim tblOffering5 As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering5)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering5.WebSiteAvailabilityIDColumn, tblOffering5.CourseInformationIDColumn, tblOffering5.TotalFeeAmountColumn, tblOffering5.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering5.OfferingIDColumn, IntOffering5ID)
            tblOffering5.TableAdapter.Load(tblOffering5, v)



            If tblOffering5.Count > 0 AndAlso tblOffering5(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering5(0)



                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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




        Dim intOfferingID As Integer = Me.OfferingID
        If intOfferingID <> -1 Then

            Dim tblOffering As New OfferingDataTable
            Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(tblOffering)
            v.Columns.AddPKColumns()
            v.Columns.EnsureColumnsAreSelected(True, False, tblOffering.WebSiteAvailabilityIDColumn, tblOffering.CourseInformationIDColumn, tblOffering.TotalFeeAmountColumn, tblOffering.OfferingTypeIDColumn)
            v.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, intOfferingID)
            tblOffering.TableAdapter.Load(tblOffering, v)



            If tblOffering.Count > 0 AndAlso tblOffering(0).WebSiteAvailabilityID.HasValue Then
                Dim item As New ShoppingCartItem()
                With tblOffering(0)



                    item.Cost = CDec(.TotalFeeAmount.Value.ToString())


                    item.Description = .GetRowDescription



                    item.ItemType = "Enrolment"

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



    End Sub

    Public Overrides Sub RenderControl(writer As HtmlTextWriter)


        'Alpha sort residence
        Dim ctlResidence As DropDownList = TryCast(fldCountryID.InternalFieldControl, DropDownList)
        SortListControl(ctlResidence, True)



        'Sort ethnic into custom list
        Dim ctlEthnicity As DropDownList = TryCast(fldEthnic.InternalFieldControl, DropDownList)

        'First Alpha sort list
        'SortListControl(ctlEthnicity, True)

        'Now find each item, remove and reinsert to position




        Dim Item1 = ctlEthnicity.Items.FindByValue("44")

        ctlEthnicity.Items.Remove(Item1)
        ctlEthnicity.Items.Insert(1, Item1)


        Dim Item2 = ctlEthnicity.Items.FindByValue("47")

        ctlEthnicity.Items.Remove(Item2)
        ctlEthnicity.Items.Insert(2, Item2)

        Dim Item3 = ctlEthnicity.Items.FindByValue("41")

        ctlEthnicity.Items.Remove(Item3)
        ctlEthnicity.Items.Insert(3, Item3)

        Dim Item4 = ctlEthnicity.Items.FindByValue("45")

        ctlEthnicity.Items.Remove(Item4)
        ctlEthnicity.Items.Insert(4, Item4)

        Dim Item5 = ctlEthnicity.Items.FindByValue("42")

        ctlEthnicity.Items.Remove(Item5)
        ctlEthnicity.Items.Insert(5, Item5)

        Dim Item6 = ctlEthnicity.Items.FindByValue("31")

        ctlEthnicity.Items.Remove(Item6)
        ctlEthnicity.Items.Insert(6, Item6)

        Dim Item7 = ctlEthnicity.Items.FindByValue("33")

        ctlEthnicity.Items.Remove(Item7)
        ctlEthnicity.Items.Insert(7, Item7)

        Dim Item8 = ctlEthnicity.Items.FindByValue("39")

        ctlEthnicity.Items.Remove(Item8)
        ctlEthnicity.Items.Insert(8, Item8)

        Dim Item9 = ctlEthnicity.Items.FindByValue("32")

        ctlEthnicity.Items.Remove(Item9)
        ctlEthnicity.Items.Insert(9, Item9)

        Dim Item10 = ctlEthnicity.Items.FindByValue("40")

        ctlEthnicity.Items.Remove(Item10)
        ctlEthnicity.Items.Insert(10, Item10)

        Dim Item11 = ctlEthnicity.Items.FindByValue("37")

        ctlEthnicity.Items.Remove(Item11)
        ctlEthnicity.Items.Insert(11, Item11)

        Dim Item12 = ctlEthnicity.Items.FindByValue("36")

        ctlEthnicity.Items.Remove(Item12)
        ctlEthnicity.Items.Insert(12, Item12)

        Dim Item13 = ctlEthnicity.Items.FindByValue("35")

        ctlEthnicity.Items.Remove(Item13)
        ctlEthnicity.Items.Insert(13, Item13)


        Dim ItemAny1 = ctlEthnicity.Items.FindByValue("43")

        ctlEthnicity.Items.Remove(ItemAny1)
        ctlEthnicity.Items.Insert(14, ItemAny1)

        Dim ItemAny2 = ctlEthnicity.Items.FindByValue("46")

        ctlEthnicity.Items.Remove(ItemAny2)
        ctlEthnicity.Items.Insert(15, ItemAny2)

        Dim ItemAny3 = ctlEthnicity.Items.FindByValue("98")

        ctlEthnicity.Items.Remove(ItemAny3)
        ctlEthnicity.Items.Insert(16, ItemAny3)

        Dim ItemAny4 = ctlEthnicity.Items.FindByValue("38")

        ctlEthnicity.Items.Remove(ItemAny4)
        ctlEthnicity.Items.Insert(17, ItemAny4)

        Dim ItemAny5 = ctlEthnicity.Items.FindByValue("34")

        ctlEthnicity.Items.Remove(ItemAny5)
        ctlEthnicity.Items.Insert(18, ItemAny5)

        Dim Item15 = ctlEthnicity.Items.FindByValue("99")

        ctlEthnicity.Items.Remove(Item15)
        ctlEthnicity.Items.Insert(19, Item15)


        MyBase.RenderControl(writer)

    End Sub

    ''Bring in the Fees
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
            vOffering.Columns.EnsureColumnsAreSelected(True, False, tblOffering.CodeColumn, tblOffering.StartTimeColumn, tblOffering.DayOfWeekColumn, tblOffering.StartDateColumn, tblOffering.EndDateColumn, tblOffering.SiteDescriptionColumn, tblOffering.EndTimeColumn, tblOffering.TotalFeeAmountColumn, tblOffering.SIDColumn, tblOffering.WebSiteAvailabilityIDColumn)
            vOffering.Columns.EnsureColumnIsSelected(False, False, tblOffering.KISCourseCodeColumn)

            vOffering.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, stb.ToString, FilterOperator.OperatorInList)

            tblOffering.TableAdapter.Load(tblOffering, vOffering)





            Me.GridView1.DataSource = tblOffering
            Me.GridView1.DataBind()
            Me.GridView1.Visible = True


        End If
    End Sub

    ''Databind the Grid
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound



        If e.Row.RowType = DataControlRowType.DataRow Then


            Dim OfferingID As Integer = CInt(DataBinder.Eval(e.Row.DataItem, "OfferingID"))

        End If
    End Sub

    Public Overrides Sub ValidateControl()


        'If StudentEnrolmentField16.Value Is Nothing Then

        '    Dim v As New CustomValidator
        '    v.IsValid = False
        '    v.ErrorMessage = "Please confirm the data processing consent"
        '    Me.Page.Validators.Add(v)
        '    chkConfirm.Attributes.Add("border:", "1 px solid red;")


        'End If


        If Not DPC.Checked Then

            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please confirm the data processing consent"
            Me.Page.Validators.Add(v)
            DPC.Attributes.Add("border:", "1 px solid red;")

        End If





        'If rdoLearnDiff.SelectedValue = "" Then


        '    Dim v As New CustomValidator
        '    v.IsValid = False
        '    v.ErrorMessage = "Do you have any learning difficulties / disabilities ?"
        '    Me.Page.Validators.Add(v)
        '    Sex.Attributes.Add("border:", "1 px solid red;")

        'End If







        If Sex.SelectedValue = "" Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please select your Gender at birth"
            Me.Page.Validators.Add(v)
            Sex.Attributes.Add("border:", "1 px solid red;")

        End If

        'If intCurrentQuals = 0 AndAlso tblQuals.Visible = True Then

        '    Dim v As New CustomValidator
        '    v.IsValid = False
        '    v.ErrorMessage = "Please add your qualifications"
        '    Me.Page.Validators.Add(v)
        '    tblQuals.Attributes.Add("border:", "1 px solid red;")

        'End If



        'If Not chkConfirm.Checked Then

        '    Dim v As New CustomValidator
        '    v.ErrorMessage = "Please confirm the declaration"
        '    v.IsValid = False
        '    Me.Page.Validators.Add(v)

        'End If









        MyBase.ValidateControl()
    End Sub



    Private Sub CheckData()



        'If Len(vacancydate.Value) > 0 Then

        '    WorkingData.EnrolmentRequestRow.ApplicationUserDefined3 = vacancydate.Value
        'End If

        If Not Sex.SelectedValue = "" Then

            WorkingData.EnrolmentRequestRow.Sex = Sex.SelectedValue

        End If






        ' WorkingData.EnrolmentRequestRow.SentMarketingInfo = 1

        WorkingData.EnrolmentRequestRow.StudentDeclaration = "Accepted Terms & Conditions as stated on: " & CStr(System.DateTime.Now)

        WorkingData.EnrolmentRequestRow.CarColour = "True"


    End Sub



    Protected Sub btnContinue_click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContinue.Click


        Dim redirectString As String = String.Empty

        Me.Page.Validate()

        'WorkingData.EnrolmentRequestRow.ProjectDossierNumber

        If Me.Page.IsValid Then


            CheckData()


            redirectString = GetResourceValue("checkout_makepayment_aspx")
            Response.Redirect(redirectString)

        End If



    End Sub


End Class

