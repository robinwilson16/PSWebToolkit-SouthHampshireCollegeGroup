Option Explicit Off
Option Strict Off
Imports System.Collections.Generic
Imports System.IO
Imports System.Linq
Imports CompassCC.CCCSystem.CCCCommon
Imports CompassCC.ProSolution.PSWebEnrolmentKit
Imports Janus.Windows.UI
Imports Microsoft.ReportingServices.Rendering.WordRenderer.WordOpenXmlRenderer.Parser

Partial Class checkout_directapplyPTF
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

    Private Property _lastAttachmentID() As Integer
        Get
            Return CInt(HttpContext.Current.Session("LastAttachmentID"))
        End Get
        Set(ByVal value As Integer)
            HttpContext.Current.Session("LastAttachmentID") = value
        End Set
    End Property
#Region "CCCPS-82076: Properties needed to optimize usage of AFD Postcode lookup"
    ''' <summary>
    ''' Set 'False' if you want to stop maintaining postcode and addresses locally during single session. Keeping this on will help us to reduce number of API calls made to find and retrieve addresses.
    ''' </summary>
    ''' <returns></returns>
    Private ReadOnly Property MaintainDataLocally As Boolean
        Get
            Return True
        End Get
    End Property
    ''' <summary>
    ''' Set 'True' if you want user to use lookup with a postcode in a valid format only.
    ''' </summary>
    ''' <returns></returns>
    Private ReadOnly Property ValidateBeforeSearch As Boolean
        Get
            Return False
        End Get
    End Property
    ''' <summary>
    ''' This property is needed to limit user from performing too many lookup operations.
    ''' </summary>
    ''' <returns></returns>
    Private Property LookupLimit As Integer
        Get
            If Session("LookupLimit") Is Nothing Then
                Session("LookupLimit") = -1 ''Set a number here to limit a user to perform lookup. Any number less than 0 means no limit will be applied.
            End If
            Return Session("LookupLimit")
        End Get
        Set(value As Integer)
            Session("LookupLimit") = value
        End Set
    End Property
    ''' <summary>
    ''' A property to hold addresses of already searched postcodes. With this, we will be able to fetch address list locally without calling an API, when same postcode is searched repetitively.
    ''' </summary>
    ''' <returns></returns>
    Private Property SearchedCodes As System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument)
        Get
            If Session("SearchedCodes") Is Nothing Then
                Session("SearchedCodes") = New System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument)
            End If
            Return Session("SearchedCodes")
        End Get
        Set(value As System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument))
            Session("SearchedCodes") = value
        End Set
    End Property
    ''' <summary>
    ''' A property to hold selected addresses (by user). With this, we will be able to retrieve address details locally without calling an API, when same address is selected repetitively.
    ''' </summary>
    ''' <returns></returns>
    Private Property FetchedAddresses As System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument)
        Get
            If Session("FetchedAddresses") Is Nothing Then
                Session("FetchedAddresses") = New System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument)
            End If
            Return Session("FetchedAddresses")
        End Get
        Set(value As System.Collections.Generic.Dictionary(Of String, System.Xml.XmlDocument))
            Session("FetchedAddresses") = value
        End Set
    End Property
#End Region


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



        If WorkingData.ShoppingCart.Items.Count > 0 Then
            Dim stb As New StringBuilder
            For Each item In WorkingData.ShoppingCart.Items

                stb.Append(item.OfferingID.ToString + ",")

            Next
            WorkingData.ApplicationRequestRow.ApplicationUserDefined29 = stb.ToString()
        End If



        Session("RequestMode") = RequestMode.ApplicationRequest


        If Not IsPostBack Then

            PutAllOfferingsInBasket()
            PopulateOfferingFeeTable()


        Else

        End If


        If IsPostBack Then
            If Request.Form("__EVENTTARGET") IsNot Nothing Then
                If Request.Form("__EVENTTARGET").EndsWith("btnFind") Then
                    btnFetchAddress.Enabled = False
                    findAddress()
                    If lstresult.SelectedIndex >= 0 Then
                        btnFetchAddress.Enabled = True
                    End If
                ElseIf Request.Form("__EVENTTARGET").EndsWith("btnFetchAddress") Then
                    UpdateAddress()
                ElseIf Request.Form("__EVENTTARGET").EndsWith("btnCSA") Then
                    SearchedCodes.Clear()
                    FetchedAddresses.Clear()
                End If
            End If
        Else
            btnFetchAddress.Enabled = False
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
    Private Sub UpdateAddress()

        ' Declare XML Objects and variables
        Dim xmlDoc As System.Xml.XmlDocument
        Dim lstStr As String
        Dim xmlLocation As String

        ' Replace lstResult with the name of your list box for the results
        With lstresult

            If lstresult.Items.Count = 0 Then
                Exit Sub
            Else
                ' Check a valid item is selected
                If .SelectedIndex < 0 Then
                    Dim v As New CustomValidator
                    v.ErrorMessage = "Please select an item from the list."
                    v.IsValid = False
                    Me.Page.Validators.Add(v)

                    Exit Sub
                End If
            End If

            ' Set XML parameter to retrieve the selected record
            lstStr = .Items.Item(.SelectedIndex).ToString

            ' Finished with the list box
        End With
        Dim addressKey As String = lstStr.Substring(lstStr.Length - 40, 40).Trim
        ''CCCPS-82076: No need to call an API to fetch address if we have it locally. 
        If MaintainDataLocally AndAlso FetchedAddresses.ContainsKey(addressKey) Then
            bindAddress(FetchedAddresses(addressKey))
            Return
        End If
        ' Create the XML Document Object Instance
        xmlDoc = New System.Xml.XmlDocument()

        ' Build up the XML query string
        xmlLocation = BuildServerDetails(SearchType.Retrieve)
        xmlLocation = xmlLocation & "&Key=" & addressKey

        ' Load the XML from the webserver with the query string
        Try

            xmlDoc.Load(xmlLocation)
            If MaintainDataLocally Then FetchedAddresses.Add(addressKey, xmlDoc)
        Catch
            Dim v As New CustomValidator
            v.ErrorMessage = "Error loading address results, please enter address manually"
            v.IsValid = False
            Me.Page.Validators.Add(v)

            Exit Sub

        End Try
        bindAddress(xmlDoc)
    End Sub
    Private Sub bindAddress(xmlDoc As System.Xml.XmlDocument)
        Dim root As System.Xml.XmlNode
        Dim dataNode As System.Xml.XmlNode
        Dim itemNodes As System.Xml.XmlNodeList
        ' Check if PCE returned an error and if the document is valid
        root = xmlDoc.DocumentElement
        dataNode = root.SelectSingleNode("Result")
        itemNodes = root.SelectNodes("Item")
        If dataNode Is Nothing Or itemNodes Is Nothing Then
            Dim v As New CustomValidator
            v.ErrorMessage = "Error loading address results, please enter address manually"
            v.IsValid = False
            Me.Page.Validators.Add(v)
            Exit Sub
        End If
        If Val(dataNode.InnerText) < 1 Then
            dataNode = root.SelectSingleNode("ErrorText")
            If dataNode Is Nothing Then
                Dim v As New CustomValidator
                v.ErrorMessage = "Error loading address results, please enter address manually"
                v.IsValid = False
                Me.Page.Validators.Add(v)
            Else
                Dim v As New CustomValidator
                v.ErrorMessage = dataNode.InnerText & vbCrLf & "Please enter address manually"
                v.IsValid = False
                Me.Page.Validators.Add(v)

            End If
            Exit Sub
        End If


        Dim strProperty As String = String.Empty

        dataNode = itemNodes(0).SelectSingleNode("Property")
        If Not (dataNode Is Nothing) Then strProperty = dataNode.InnerText

        dataNode = itemNodes(0).SelectSingleNode("Street")
        If Not (dataNode Is Nothing) Then
            If Not CCCBlankLibrary.IsBlank(strProperty) Then
                txtAddress1.Value = String.Format("{0}, {1}", strProperty, dataNode.InnerText)
            Else
                txtAddress1.Value = dataNode.InnerText
            End If
        End If

        dataNode = itemNodes(0).SelectSingleNode("Locality")
        If Not (dataNode Is Nothing) Then txtAddress2.Value = dataNode.InnerText

        dataNode = itemNodes(0).SelectSingleNode("Town")
        If Not (dataNode Is Nothing) Then txtAddress3.Value = dataNode.InnerText

        dataNode = itemNodes(0).SelectSingleNode("PostalCounty")
        If Not (dataNode Is Nothing) Then txtAddress4.Value = dataNode.InnerText

        dataNode = itemNodes(0).SelectSingleNode("Postcode")
        If Not (dataNode Is Nothing) Then
            'txtpostcodeout.Value = Trim(dataNode.InnerText.Substring(0, InStr(1, dataNode.InnerText, " ")))
            'txtpostcodein.Value = Trim(Mid(dataNode.InnerText, InStr(1, dataNode.InnerText, " ") + 1))
            If Not (dataNode Is Nothing) Then postcode.Value = dataNode.InnerText
        End If
    End Sub
    Private Sub findAddress()
        ' Clear out any existing items in the list
        lstresult.Items.Clear()
        If String.IsNullOrWhiteSpace(txtLookup.Text) Then
            Dim v As New CustomValidator
            v.ErrorMessage = "Please enter a search term."
            v.IsValid = False
            Me.Page.Validators.Add(v)
            Return
        End If
        If ValidateBeforeSearch Then
            Dim regexPostCode As New Regex("^([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})$")
            Dim match As Match = regexPostCode.Match(txtLookup.Text)
            If Not match.Success Then
                Dim v As New CustomValidator
                v.ErrorMessage = "Please enter a valid Postcode"
                v.IsValid = False
                Me.Page.Validators.Add(v)
                Return
            End If
        End If
        If MaintainDataLocally AndAlso SearchedCodes.ContainsKey(txtLookup.Text) Then
            GetSearchResults(SearchedCodes(txtLookup.Text))
            Return
        End If
        If LookupLimit = 0 Then
            Dim v As New CustomValidator
            v.ErrorMessage = "The address has been looked up too many times. Please enter manually."
            v.IsValid = False
            Me.Page.Validators.Add(v)
            Return
        End If
        ' Declare XML Objects and variables
        Dim xmlDoc As System.Xml.XmlDocument
        Dim xmlLocation As String

        ' Create the XML Document Object Instance
        xmlDoc = New System.Xml.XmlDocument()

        ' Replace lstResult with the name of your list box for the results
        With lstresult

            ' Build up the XML query string
            xmlLocation = BuildServerDetails(SearchType.FastFind)

            ' Set the Country Name or ISO code for International operations
            xmlLocation = xmlLocation & "&Country=UK"

            ' Set the lookup string
            xmlLocation = xmlLocation & "&Lookup=" & txtLookup.Text ' Change txtLookup to your lookup entry textbox

            ' Load the XML from the webserver with the query string
            Try
                xmlDoc.Load(xmlLocation)
                If MaintainDataLocally Then SearchedCodes.Add(txtLookup.Text, xmlDoc)
                LookupLimit -= 1
            Catch
                Dim v As New CustomValidator
                v.ErrorMessage = "Error loading address results, please enter address manually"
                v.IsValid = False
                Me.Page.Validators.Add(v)
                Exit Sub
            End Try

            GetSearchResults(xmlDoc)

        End With


    End Sub
    Private Function BuildServerDetails(ByVal Type As SearchType) As String
        Dim xmlLocation As String
        ' Build up the XML query string
        xmlLocation = AFD_SERVER & "/afddata.pce?"
        xmlLocation = xmlLocation & "Serial=" & AFD_SERIAL_NUMBER & "&"
        xmlLocation = xmlLocation & "Password=" & AFD_PASSWORD & "&"
        xmlLocation = xmlLocation & "UserID=" & AFD_USER_ID & "&"

        Select Case Type
            Case SearchType.FastFind
                xmlLocation = xmlLocation & "Data=Address&Task=FastFind&Fields=List"
            Case SearchType.Search
                xmlLocation = xmlLocation & "Data=Address&Task=Search&Fields=List"
            Case SearchType.Retrieve
                xmlLocation = xmlLocation & "Data=Address&Task=Retrieve&Fields=Standard"
            Case Else

        End Select

        ' Set the maximum number of records to return
        xmlLocation = xmlLocation & "&MaxQuantity=100"

        Return xmlLocation
    End Function

    Private Sub GetSearchResults(xmlDoc As System.Xml.XmlDocument)
        Dim root As System.Xml.XmlNode
        Dim pcFromNode As System.Xml.XmlNode
        Dim dataNode As System.Xml.XmlNode
        Dim itemNodes As System.Xml.XmlNodeList
        Dim listNode As System.Xml.XmlNode
        Dim keyNode As System.Xml.XmlNode
        With lstresult
            ' Check if PCE returned an error and if the document is valid
            root = xmlDoc.DocumentElement
            dataNode = root.SelectSingleNode("Result")
            itemNodes = root.SelectNodes("Item")
            If dataNode Is Nothing Or itemNodes Is Nothing Then
                Dim v As New CustomValidator
                v.ErrorMessage = "Error loading address results, please enter address manually"
                v.IsValid = False
                Me.Page.Validators.Add(v)
                Exit Sub
            End If
            If Val(dataNode.InnerText) < 1 Then
                dataNode = root.SelectSingleNode("ErrorText")
                If dataNode Is Nothing Then
                    Dim v As New CustomValidator
                    v.ErrorMessage = "Error loading address results, please enter address manually"
                    v.IsValid = False
                    Me.Page.Validators.Add(v)
                Else
                    Dim v As New CustomValidator
                    v.ErrorMessage = dataNode.InnerText & vbCrLf & "Please enter address manually"
                    v.IsValid = False
                    Me.Page.Validators.Add(v)
                End If
                Exit Sub
            End If

            ' Display any changed postcode if applicable
            pcFromNode = itemNodes(0).SelectSingleNode("PostcodeFrom")
            dataNode = itemNodes(0).SelectSingleNode("Postcode")
            If Not (pcFromNode Is Nothing) And Not (dataNode Is Nothing) Then
                If pcFromNode.InnerText <> "" Then
                    Dim v As New CustomValidator
                    v.ErrorMessage = "Postcode has changed from " & pcFromNode.InnerText & " to " & dataNode.InnerText
                    v.IsValid = True
                    Me.Page.Validators.Add(v)
                End If
            End If

            ' Now add matching records to the list box
            For Each dataNode In itemNodes
                ' Get the data nodes
                listNode = dataNode.SelectSingleNode("List")
                keyNode = dataNode.SelectSingleNode("Key")
                If Not (listNode Is Nothing) And Not (keyNode Is Nothing) Then
                    ' Add the item to the list box with hidden key
                    .Items.Add(listNode.InnerText & Space(512) & keyNode.InnerText)
                End If
            Next

            If .Items.Count() <> 0 Then .SelectedIndex = 0 ' Select First item in the list

        End With
    End Sub





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
        '
        '

        If Not DPC.Checked Then

            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please confirm the data processing consent"
            Me.Page.Validators.Add(v)
            DPC.Attributes.Add("border:", "1 px solid red;")

        End If



        If fldSchoolID.Value = "" Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please enter a previous / current school"
            Me.Page.Validators.Add(v)
            '  chkConfirm.Attributes.Add("border:", "1 px solid red;")

        End If


        If Not chkConfirm.Checked Then

            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please confirm you have read the declaration"
            Me.Page.Validators.Add(v)
            chkConfirm.Attributes.Add("border:", "1 px solid red;")
        End If

        If RadioButtonListEU.SelectedValue = "0" AndAlso Len(DOEUK.Value) = 0 Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Please enter your date of entry into the UK "
            Me.Page.Validators.Add(v)
            Sex.Attributes.Add("border:", "1 px solid red;")

        End If

        If RadioButtonListEU.SelectedValue = "1" AndAlso fldCountryID.Value Is Nothing Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "please enter your country of origin"
            Me.Page.Validators.Add(v)
            Sex.Attributes.Add("border:", "1 px solid red;")

        End If
        If rdoLearnDiff.SelectedValue = "" Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Do you have any learning difficulties / disabilities ?"
            Me.Page.Validators.Add(v)
            'Sex.Attributes.Add("border:", "1 px solid red;")

        End If




        If RadioButtonListEU.SelectedValue = "" Then


            Dim v As New CustomValidator
            v.IsValid = False
            v.ErrorMessage = "Are you a UK citizen?"
            Me.Page.Validators.Add(v)
            Sex.Attributes.Add("border:", "1 px solid red;")

        End If

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



        If Len(txtAddress1.Value) = 0 Then
            Dim v As New CustomValidator
            v.ErrorMessage = "You must enter the 1st line of the address"
            v.IsValid = False
            Me.Page.Validators.Add(v)
            txtAddress1.Style.Add("border", "1px solid red")
        End If

        'If Len(txtAddress2.Value) = 0 Then
        '    Dim v As New CustomValidator
        '    v.ErrorMessage = "You must enter the 2nd line of the address"
        '    v.IsValid = False
        '    Me.Page.Validators.Add(v)
        '    txtAddress2.Style.Add("border", "1px solid red")
        'End If

        If Len(postcode.Value) = 0 Then
            Dim v As New CustomValidator
            v.ErrorMessage = "You must enter the postcode"
            v.IsValid = False
            Me.Page.Validators.Add(v)
            postcode.Style.Add("border", "1px solid red")
        End If





        MyBase.ValidateControl()
    End Sub


    Private Sub CheckData()

        If Not Sex.SelectedValue = "" Then

            WorkingData.ApplicationRequestRow.Sex = Sex.SelectedValue
        End If


        If Len(DOEUK.Value) > 0 Then

            WorkingData.ApplicationRequestRow.DateOfEntryUK = CStr(DOEUK.Value)
        End If





        WorkingData.ApplicationRequestRow.Address1 = txtAddress1.Value
        WorkingData.ApplicationRequestRow.Address2 = txtAddress2.Value
        WorkingData.ApplicationRequestRow.Address3 = txtAddress3.Value
        WorkingData.ApplicationRequestRow.Address4 = txtAddress4.Value

        Dim pcode As String = Replace(postcode.Value, " ", "")
        If Len(pcode) > 0 Then

            'avoid dodgy postcodes breaking system
            Try
                WorkingData.EnrolmentRequest(0).PostcodeOut = pcode.Substring(0, pcode.Length - 3)
            Catch ex As ArgumentOutOfRangeException
                WorkingData.EnrolmentRequest(0).PostcodeOut = ""
            End Try

            Try
                WorkingData.EnrolmentRequest(0).PostcodeIn = Right(pcode, 3)
            Catch ex As ArgumentOutOfRangeException
                WorkingData.EnrolmentRequest(0).PostcodeIn = ""
            End Try


        End If

        'WorkingData.ApplicationRequestRow.SentMarketingInfo = 1
        'WorkingData.ApplicationRequestRow.AcceptMarketingConsent = 1
        'WorkingData.ApplicationRequestRow.AcceptShareInfoConsent = 1

        WorkingData.ApplicationRequestRow.StudentDeclaration = "Accepted Terms & Conditions as stated on: " & CStr(System.DateTime.Now)

        WorkingData.ApplicationRequestRow.CarColour = "True"


    End Sub



    Protected Sub btnContinue_click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContinue.Click


        Dim redirectString As String = String.Empty

        WorkingData.ApplicationRequestRow.EuroResidentID = Nothing

        Me.Page.Validate()


        If Me.Page.IsValid Then


            CheckData()


            redirectString = GetResourceValue("checkout_makepayment_aspx")
            Response.Redirect(redirectString)

        End If



    End Sub


End Class
