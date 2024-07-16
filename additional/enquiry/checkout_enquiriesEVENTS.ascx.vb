Option Explicit On
Option Strict On

Imports CompassCC.CCCSystem.CCCCommon
Imports CompassCC.ProSolution.PSWebEnrolmentKit

Partial Class webcontrols_checkout_enquiriesEVENTS
    Inherits CheckoutBaseControl
    Public ReadOnly Property OfferingID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("OfferingID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("OfferingID"))
            End If
        End Get
    End Property


    Public ReadOnly Property OpenEventID() As Integer
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("OpenEventID")) Then
                Return -1
            Else
                Return CInt(Me.Page.Request("OpenEventID"))
            End If
        End Get
    End Property
    Protected Overrides Sub OnLoad(e As EventArgs)
        MyBase.OnLoad(e)

        If PaymentSubmitter.AllowEmptyBasket And WorkingData.ShoppingCart.Items.Count = 0 Then
            Session("RequestMode") = RequestMode.EnquiryRequest
        End If


        If Not IsPostBack Then

        End If




    End Sub



    Protected Sub PutAllOfferingsInBasket()



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

                    item.Cost = 0
                    item.Description = .GetRowDescription
                    item.ItemType = "Enquiry"

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
            vOffering.Columns.EnsureColumnsAreSelected(True, False, tblOffering.CodeColumn, tblOffering.StartTimeColumn, tblOffering.DayOfWeekColumn, tblOffering.StartDateColumn, tblOffering.EndDateColumn, tblOffering.SiteDescriptionColumn, tblOffering.EndTimeColumn, tblOffering.TotalFeeAmountColumn, tblOffering.SIDColumn, tblOffering.WebSiteAvailabilityIDColumn, tblOffering.CourseInformationColumn, tblOffering.DayOfWeekColumn, tblOffering.NumberOfWeeksColumn)
            vOffering.Columns.EnsureColumnIsSelected(False, False, tblOffering.KISCourseCodeColumn)

            vOffering.Filters.SetColumnFilter(tblOffering.OfferingIDColumn, stb.ToString, FilterOperator.OperatorInList)

            tblOffering.TableAdapter.Load(tblOffering, vOffering)







        End If
    End Sub
    Public Overrides Sub ValidateControl()


        If Not chkData.Checked Then


            Dim v As New CustomValidator
            v.ErrorMessage = "Please accept the data processing consent"
            v.IsValid = False
            Me.Page.Validators.Add(v)

        End If

        If Not datepicker.Value Is "" Then



            Dim DobDate As Date = CDate(datepicker.Value)



            If DateDiff(DateInterval.Day, DobDate, Now) < (13 * 365) Then


                Dim v As New CustomValidator
                v.IsValid = False
                v.ErrorMessage = "Please check your date of birth - you must be over 13 to enquire"
                Me.Page.Validators.Add(v)




                Exit Sub

            End If

        Else


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please enter your date of birth"
            Me.Page.Validators.Add(v)


        End If

        MyBase.ValidateControl()


    End Sub


    Protected Sub btnContinue_click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContinue.Click


        Me.Page.Validate()

        If Me.Page.IsValid Then

            If Not OpenEventID = -1 Then

                WorkingData.EnquiryRequestRow.EnquiryUserDefined10 = OpenEventID.ToString()

            End If

            WorkingData.EnquiryRequestRow.EnquiryUserDefined2 = "OpenEvent"
            '  WorkingData.EnquiryRequestRow.DateOfBirth = CDate(DoB.Text)

        End If


    End Sub



End Class
