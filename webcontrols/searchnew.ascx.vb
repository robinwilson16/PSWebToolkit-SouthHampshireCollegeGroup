Imports CompassCC.CCCSystem
Imports CompassCC.CCCSystem.CCCCommon
Imports CompassCC.ProSolution.PSWebEnrolmentKit
Imports System.Collections.Generic
Imports System.Linq
Imports System.Reflection

Partial Class webcontrols_searchnew
    Inherits webenrolmentcontrolvalidate


    Dim m_CoursesInBasket As System.Collections.Generic.List(Of Integer)

    'These properties will hode/show the example extra search fields
    ''' <summary>
    ''' Set true to Show Site filter.
    ''' </summary>
    Private ShowSite As Boolean = True
    ''' <summary>
    ''' Set true to Show College Level filter.
    ''' </summary>
    Private ShowCollegeLevel As Boolean = False
    ''' <summary>
    ''' Set true to Show Mode of Attendance filter.
    ''' </summary>
    Private ShowModeOfAttendance As Boolean = False
    ''' <summary>
    ''' Set true to show an option to change page size.
    ''' </summary>
    Private ShowItemsPerPage As Boolean = False
    ''' <summary>
    ''' PK IDs of Site (comma separated) to be excluded from the result.
    ''' </summary>
    Private ExcludedSiteIDs As String = ""

    Private _objMarketingFields As MarketingFields
    Private Property objMarketingFields() As MarketingFields
        Get
            If _objMarketingFields Is Nothing Then
                _objMarketingFields = New MarketingFields()
            End If
            Return _objMarketingFields
        End Get
        Set(ByVal value As MarketingFields)
            _objMarketingFields = value
        End Set
    End Property
    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        LoadGridData()
        'An object to manage everything related to marketing fields.
        'NOTE: Set necessary values in below object to setup marketing fields on search page.
        objMarketingFields = New MarketingFields() With {
                .ShowMarketingField1 = True,
                .ShowMarketingField2 = True,
                .ShowMarketingField3 = False,
                .MarketingField1Caption = "Level",
                .MarketingField2Caption = "Mode",
                .MarketingField3Caption = "MOA",
                .MarketingField1CourseInformationTypeID = 16,
                .MarketingField2CourseInformationTypeID = 15,
                .MarketingField3CourseInformationTypeID = 17,
                .UseMarketingField1ForImage = False,
                .UseMarketingField2ForSubImage = False
        }
        'Creating dynamic controls for Marketing fields.
        objMarketingFields.CreateMarketingFieldControls(Me.DesignMode, SearchAreaForMarketingFields)
    End Sub
    Protected Overrides Sub OnLoad(ByVal e As System.EventArgs)
        MyBase.OnLoad(e)


        LoadGridData()

        ''Need to build the image table each time or we can hook up to the image clicks
        objMarketingFields.LoadImageTable(listviewGraphic, CBool(ViewState("Searched")))

        If Not IsPostBack Then
            PopulateDropDownLists()
        Else
            ''Rebinding Marketing Field 2 to reload control based on the value selected in Marketing Field 1.
            objMarketingFields.PopulateMarketingField(objMarketingFields.CtlMarketingField2, objMarketingFields.MarketingField2CourseInformationTypeID, objMarketingFields.MarketingField2)
        End If
    End Sub

    Private Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        dpSearchGrid.PageSize = cboPageSize.SelectedValue
        LoadGridData()

        ViewState("Searched") = True
        objMarketingFields.LoadImageTable(listviewGraphic, CBool(ViewState("Searched")))
    End Sub

    Private Sub btnShowAll_Click(sender As Object, e As EventArgs) Handles btnShowAll.Click
        'Clear search values first...
        Me.txtKeywords.Text = ""
        cboCollegeLevel.SelectedValue = Nothing
        cboSite.SelectedValue = Nothing
        'Then load grid
        LoadGridData()
    End Sub
    Private Sub PopulateDropDownLists()
        'Populate drop down lists etc.
        '... or alteratvively hide the saerch fields that aren't being used

        If ShowSite Then
            cboSite.Items.Add(New WebControls.ListItem("All", ""))
            'NOTE: PopulateListWithDescriptionColumns is a v simple way of using CCCListControlLibrary
            CCCListControlLibrary.PopulateListWithDescriptionColumns(New SiteDataTable, cboSite, True, ExcludedSiteIDs)
        Else
            SearchAreaForSite.Visible = False
        End If

        If ShowCollegeLevel Then
            'NOTE: PopulateList with more flexible options on creating the lookup using the CCCListControlLibrary
            Dim tblCollegeLevel = New CollegeLevelDataTable
            Dim vCollegeLevel = CCCDataViewDataSet.CreateDataViewDefault(tblCollegeLevel)

            vCollegeLevel.Filters.SetColumnFilter(tblCollegeLevel.LevelNumColumn, 3, FilterOperator.OperatorEquals)  'Restrict to 4th College Level CL4
            Dim l = New CCCLookup(tblCollegeLevel, vCollegeLevel)
            CCCListControlLibrary.PopulateList(l, cboCollegeLevel, True)
        Else
            SearchAreaForCollegeLevel.Visible = False
        End If
        ''CCCPS-76485: Added new filters for Mode of Attendance and Items per page.
        If ShowModeOfAttendance Then
            'NOTE: PopulateListWithDescriptionColumns is a v simple way of using CCCListControlLibrary
            CCCListControlLibrary.PopulateListWithDescriptionColumns(New ModeOfAttendanceDataTable, cboModeOfAttendance, True)
        Else
            SearchAreaForModeOfAttendance.Visible = False
        End If
        If Not ShowItemsPerPage Then
            SearchAreaForPageSize.Visible = False
        End If
    End Sub

    Public ReadOnly Property Keywords() As String
        Get
            If Me.DesignMode OrElse CCCBlankLibrary.IsBlank(Me.Page.Request("Keywords")) Then
                Return -1
            Else
                Return CStr(Me.Page.Request("Keywords"))
            End If
        End Get
    End Property

#Region " Grid "

    Sub LoadGridData()

        Dim tblCourseInfo As New CourseInformationDataTable

        Dim vCourseInfo As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataViewDefault(tblCourseInfo)
        vCourseInfo.Columns.Clear()
        vCourseInfo.Columns.AddPKColumns()
        'add extra here columns we will need to expand search array
        vCourseInfo.Columns.EnsureColumnsAreSelected(True, False, tblCourseInfo.DescriptionColumn, tblCourseInfo.AcademicYearIDColumn, tblCourseInfo.WebsiteAvailabilityIDColumn, tblCourseInfo.CourseInfoDescriptionColumn, tblCourseInfo.CourseInformationColumn, tblCourseInfo.CollegeLevelNameColumn)
        vCourseInfo.Filters.SetColumnFilter(tblCourseInfo.ObsoleteColumn, False)
        vCourseInfo.Filters.SetColumnFilter(tblCourseInfo.WebsiteAvailabilityIDColumn, "0,1", FilterOperator.OperatorNotInList)

        vCourseInfo.SortOrders.Clear()
        vCourseInfo.SortOrders.SetColumnSortOrder(SortDirection.Ascending, tblCourseInfo.DescriptionColumn)

        'Add Search

        'modify so if txtkeywords is not blank string, otherwise use the query string (first load up) 

        If Len(txtKeywords.Text) > 0 Then
            Dim SearchText = Server.HtmlEncode(Me.txtKeywords.Text & "%")
            Dim ColumnsToSearch = {tblCourseInfo.DescriptionColumn}
            vCourseInfo.Filters.AddSearchColumns(ColumnsToSearch, SearchText)
        ElseIf Len(Me.Keywords) > 0 Then
            'search on query string
            Dim SearchText = Server.HtmlEncode(Me.Keywords & "%")
            Dim ColumnsToSearch = {tblCourseInfo.DescriptionColumn}
            vCourseInfo.Filters.AddSearchColumns(ColumnsToSearch, SearchText)

        ElseIf Len(Me.Keywords) = 0 AndAlso Len(txtKeywords.Text) = 0 Then

            Dim SearchText = ""
            Dim ColumnsToSearch = {tblCourseInfo.DescriptionColumn}
            vCourseInfo.Filters.AddSearchColumns(ColumnsToSearch, SearchText)

        End If



        Dim writer As DataAccess.CCCSQLLanguageWriter = CCCObjectFactory.CreateObject(Of DataAccess.CCCSQLLanguageWriter)() 'Create SQL language writer for SanitiseSQLValueString
        If Not CCCBlankLibrary.IsBlank(objMarketingFields.MarketingField1) AndAlso objMarketingFields.MarketingField1 <> "All" Then
            Dim str = "EXISTS(SELECT * FROM CourseInformationText CT WHERE CT.CourseInformationID = CourseInformation.CourseInformationID " &
        "AND CT.InformationText LIKE '%" & writer.SQLLanguageFormatter.SanitiseSQLValueString(objMarketingFields.MarketingField1, False) & "%'" &
        "AND CT.CourseInformationTypeID = " & objMarketingFields.MarketingField1CourseInformationTypeID & ")"
            vCourseInfo.Filters.AddRow(str)
        End If

        If Not CCCBlankLibrary.IsBlank(objMarketingFields.MarketingField2) AndAlso objMarketingFields.MarketingField2 <> "All" Then
            Dim str = "EXISTS(SELECT * FROM CourseInformationText CT WHERE CT.CourseInformationID = CourseInformation.CourseInformationID " &
       "AND CT.InformationText LIKE '%" & writer.SQLLanguageFormatter.SanitiseSQLValueString(objMarketingFields.MarketingField2, False) & "%'" &
       "AND CT.CourseInformationTypeID = " & objMarketingFields.MarketingField2CourseInformationTypeID & ")"
            vCourseInfo.Filters.AddRow(str)
        End If
        If Not CCCBlankLibrary.IsBlank(objMarketingFields.MarketingField3) AndAlso objMarketingFields.MarketingField3 <> "All" Then
            Dim str = "EXISTS(SELECT * FROM CourseInformationText CT WHERE CT.CourseInformationID = CourseInformation.CourseInformationID " &
       "AND CT.InformationText LIKE '%" & writer.SQLLanguageFormatter.SanitiseSQLValueString(objMarketingFields.MarketingField3, False) & "%'" &
      "AND CT.CourseInformationTypeID = " & objMarketingFields.MarketingField3CourseInformationTypeID & ")"
            vCourseInfo.Filters.AddRow(str)
        End If





        tblCourseInfo.TableAdapter.Load(tblCourseInfo, vCourseInfo)

        SearchGrid.DataSource = tblCourseInfo

        m_CoursesInBasket = New System.Collections.Generic.List(Of Integer)
        For Each item As ShoppingCartItem In WorkingData.ShoppingCart.Items
            m_CoursesInBasket.Add(item.CourseInfoID)
        Next

        SearchGrid.DataBind()

    End Sub

    Private Sub m_Grid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles SearchGrid.ItemDataBound#
        Dim item As ListViewItem = e.Item
        ' Verify if the item is a data item.
        If item.ItemType = ListViewItemType.DataItem Then
            Dim rowView As System.Data.DataRowView
            rowView = CType(e.Item, System.Web.UI.WebControls.ListViewDataItem).DataItem
            Dim img As HyperLink = e.Item.FindControl("ApplyOrEnrolmentBtn")
            SetWebSiteAvailabilityIcon(img, rowView)

            If rowView.Row.Table.Columns.Contains("_SearchScore") Then
                Dim lbl As Label = e.Item.FindControl("lblScore")
                FormatScore(lbl, rowView)
            End If
        End If
    End Sub
    Dim m_blnPageChanged As Boolean = False
    Private Sub m_Grid_PagePropertiesChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchGrid.PagePropertiesChanged
        LoadGridData()
        m_blnPageChanged = True
    End Sub
    Private Sub m_DataPager_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles dpSearchGrid.PreRender
        If ViewState("Searched") = True AndAlso Not m_blnPageChanged Then
            dpSearchGrid.SetPageProperties(0, dpSearchGrid.MaximumRows, True)
        End If
    End Sub
    Private Sub FormatScore(ByVal lblScore As Label, ByVal rowView As System.Data.DataRowView)
        Dim dataValue As String = rowView("_SearchScore").ToString
        lblScore.Text = CInt(dataValue).ToString & "%"
    End Sub
    Private Sub SetWebSiteAvailabilityIcon(ByVal img As HyperLink, ByVal rowView As System.Data.DataRowView)
        Dim dataValue As String = rowView("WebSiteAvailabilityID").ToString
        Dim intCourseInfoID As Integer = CInt(rowView("CourseInformationID"))
        Dim imageURL As String = String.Empty
        Dim imageText As String = String.Empty
        Dim NavigateUrl As String = String.Empty

        If m_CoursesInBasket.Contains(intCourseInfoID) Then
            imageText = "Course already in basket"
            imageURL = GetResourceValue("basketsmall")
            NavigateUrl = GetResourceValue("checkout_aspx")
        ElseIf CCCBlankLibrary.IsBlank(dataValue) Then
            imageURL = GetResourceValue("icon_noofferings")
            NavigateUrl = GetResourceValue("courseunavailable_aspx")
        Else
            Dim Availability As Byte = CType(dataValue, Byte)
            Dim row As WebSiteAvailabilityRow = WebSiteAvailabilityTable.FindByWebSiteAvailabilityID(Availability)
            If row IsNot Nothing Then
                imageText = row.Description
                If Len(row.IconFileName) = 0 Then
                    imageURL = GetResourceValue("gap")
                Else
                    imageURL = GetResourceValue(Replace(row.IconFileName, ".png", ""))
                End If
                NavigateUrl = GetResourceValue("coursedisplay_aspx") & IIf(GetResourceValue("coursedisplay_aspx").Contains("?"), "&", "?").ToString & "CourseInformationID=" & intCourseInfoID.ToString
            Else
                imageURL = GetResourceValue("icon_noofferings")
                NavigateUrl = GetResourceValue("courseunavailable_aspx")
            End If

        End If

        img.Text = imageText
        img.ImageUrl = imageURL
        img.NavigateUrl = NavigateUrl
    End Sub

    Private m_tblWebSiteAvailability As WebSiteAvailabilityDataTable
    Private Property WebSiteAvailabilityTable() As WebSiteAvailabilityDataTable
        Get
            If m_tblWebSiteAvailability Is Nothing Then
                m_tblWebSiteAvailability = New WebSiteAvailabilityDataTable
                Dim v As CCCDataViewDataSet = CCCDataViewDataSet.CreateDataView(m_tblWebSiteAvailability)
                v.Columns.AddAllColumns(False, False)
                m_tblWebSiteAvailability.TableAdapter.Load(m_tblWebSiteAvailability, v)
            End If
            Return m_tblWebSiteAvailability
        End Get
        Set(ByVal value As WebSiteAvailabilityDataTable)
            m_tblWebSiteAvailability = value
        End Set
    End Property

#End Region
    ''' <summary>
    ''' Setting up image and text again each marketing field type list view.
    ''' </summary>
    ''' <param name="sender">sender</param>
    ''' <param name="e">e</param>
    Public Sub m_ImageTable_ItemDataBound(ByVal sender As Object, ByVal e As UI.WebControls.ListViewItemEventArgs) Handles listviewGraphic.ItemDataBound
        Dim item As ListViewItem = e.Item
        ' Verify if the item is a data item.
        If item.ItemType = ListViewItemType.DataItem Then
            Dim rowView As System.Data.DataRowView
            rowView = CType(e.Item, UI.WebControls.ListViewDataItem).DataItem
            Dim imgMarketing As Button = e.Item.FindControl("btnMarketingGraphic")
            Dim lblMarketing As Label = e.Item.FindControl("lblCourseInformationType")
            ''Setting marketing image here
            Dim Value As String = rowView("Value")
            Dim strDescription As String = rowView("Description")
            Dim imageUrl As String = GetResourceValue(Value)
            If Len(imageUrl) = 0 Then
                imageUrl = String.Format("_images/search/{0}.png", Value)
            End If

            imgMarketing.ID = "img_" & Value
            imgMarketing.Attributes.Add("style", "height:120px;background-image:url(" & imageUrl & ")")

            'img.AlternateText = strDescription
            imgMarketing.Attributes.Add("runat", "server")
            lblMarketing.Text = strDescription
            AddHandler imgMarketing.Click, AddressOf Button_Click
        End If
    End Sub
    ''' <summary>
    ''' Marketing image click event which will filter data based on clicked course info type.
    ''' </summary>
    ''' <param name="sender">sender</param>
    ''' <param name="e">e</param>
    Protected Sub Button_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim imgMarketing As Button = CType(sender, Button)
        Dim fieldName As String = imgMarketing.ID.Substring(imgMarketing.ID.IndexOf("_") + 1)
        If objMarketingFields.MarketingField1 <> "All" AndAlso ViewState("Searched") = True Then
            objMarketingFields.MarketingField2 = fieldName
        Else
            objMarketingFields.MarketingField1 = fieldName
            objMarketingFields.MarketingField2 = Nothing
        End If

        LoadGridData()

        ViewState("Searched") = True
        objMarketingFields.LoadImageTable(listviewGraphic, CBool(ViewState("Searched")))
        objMarketingFields.PopulateMarketingField(objMarketingFields.CtlMarketingField2, objMarketingFields.MarketingField2CourseInformationTypeID, objMarketingFields.MarketingField2)
    End Sub
End Class
