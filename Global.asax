<%@ Application Language="VB" %>
<%@ Import Namespace="CompassCC.CCCSystem.CCCCommon" %>
<%@ Import Namespace="CompassCC.ProSolution.PSWebEnrolmentKit" %>

<script RunAt="server">

    Dim m_blnInitialised As Boolean


    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup

        Initialise()

        m_blnInitialised = True

    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        Try
            'Get the last error that occured and save it in a session
            Dim exceptionContainer As Exception = Server.GetLastError

            'Write the error to the session if it is available
            If Not System.Web.HttpContext.Current.Session Is Nothing Then
                Session("LastError") = exceptionContainer

                'Need to do this to not destroy the session
                'Server.ClearError()

                'Response.Redirect("~/GenericError.aspx")
            End If

        Catch ex As Exception
            Diagnostics.Debug.WriteLine(ex.Message)
        End Try
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started

        If Not m_blnInitialised Then
            'In case of errors during startup (E.g. Database server not running)
            Initialise()
            m_blnInitialised = True
        End If

        Session.LCID = 2057 'Set Locale to UK (Ignoring regional settings of computer)
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    Private Sub Initialise()



        CCCDataCache.DisableAllCaching = True
        CCCConfigLibrary.ReadConfigFromConfigFile(IO.Path.Combine(HttpRuntime.AppDomainAppPath, "web.config"))
        CCCConfigLibrary.ReadConfigFromConfigFile(IO.Path.Combine(HttpRuntime.AppDomainAppPath, "web.dbconfig"))
        CCCConfigLibrary.ReadConfigFromMyAppDBConfigFile()
        CCCDatabaseConnectInfoList.LoadDatabaseInfoFromConfig()


        'Set timeout values from config
        CCCConfigLibrary.SetAllFrameworkValuesFromConfig()

        CCCObjectFactory.InitialiseForAssembly(GetType(CompassCC.ProSolution.PSWebEnrolmentKit.EnrolmentRequestDataTable).Assembly, AssemblyType.Business)

        'Configure/check connections
        Dim rules As CCCBrokenRulesList = CCCDatabaseConnectionLibrary.CheckDBConnectionInfos(CCCDatabaseConnectInfoList.GetDatabaseConnectInfos(), False)
        If Not rules.IsAllValid Then
            Throw New CCCTechnicalException("One or more database connections is not valid: " & rules.GetBrokenRulesText())
        End If

        If CCCDatabaseConnectInfo.DefaultDatabaseDBInfo IsNot Nothing Then
            'Load metadata from default database
            CCCMetaData.InitialiseForDatabase(CCCDatabaseConnectInfo.DefaultDatabaseDBInfo)
        End If

        CCCEnvironmentLibrary.ApplicationInfo_ProductName = "ProSolution Web Toolkit"
        'Custom Control Settings

        CCCWebField.ShouldCreateRequiredFieldIcon = False
        CCCWebField.UseProSolutionMetadata = False

        CheckoutBaseControl.ShouldCheckBasketNotEmpty = False

        WorkingData.Provider = New SessionWorkingDataProvider

        PaymentSubmitter.ShouldSendEmailConfirmation = False
        PaymentSubmitter.AllowEmptyBasket = true
        PaymentSubmitter.ShouldValidateAge = False
        PaymentSubmitter.MinimumAge = 16
        PaymentSubmitter.ShouldMakeNewApplicationForEachOffering = True
        Toastr.UseToastr = True


        'System Settings
        SystemSettings.AcademicYearID = "23/24"

        SystemSettings.CollegeOrganisationID = 0

        'DB Timeouts
        SystemSettings.DefaultTimeout = 600
        SystemSettings.DefaultLongTimeout = 12000

        'Proxy Server for web requests to pass through
        SystemSettings.ProxyDomain = ""
        SystemSettings.ProxyPassword = ""
        SystemSettings.ProxyURL = ""
        SystemSettings.ProxyUserName = ""

        'QAS Pro Web Settings
        SystemSettings.QAS_Layout = "Database Layout"
        SystemSettings.QAS_ServerURL = ""

        'KIS Widget URL Settings. For example. "https://discoveruni.org.uk/widget/" If not set, default will be "https://widget.unistats.ac.uk/Widget/"
        SystemSettings.KISWidgetURL = ""

        'QAS On Demand Settings
        SystemSettings.QASOnDemand_Password = ""
        SystemSettings.QASOnDemand_URL = ""
        SystemSettings.QASOnDemand_Username = ""

        'AFD Postcode Evolution Settings
        SystemSettings.AFDEvolution_Password = "U2Gex4Cf"
        SystemSettings.AFDEvolution_SerialNumber = "832572"
        SystemSettings.AFDEvolution_Server = "https://pce.afd.co.uk"
        SystemSettings.AFDEvolution_UserID = ""

        'Capscan On Demand Settings
        SystemSettings.Capscan_AccessCode = ""
        SystemSettings.Capscan_ClientID = ""

        'Matchcode360 Settings
        SystemSettings.UseMatchcode360 = False
        SystemSettings.Matchcode360Username = ""
        SystemSettings.Matchcode360Password = ""
        SystemSettings.Matchcode360API = "https://idmp.gb.co.uk/idm-powersearch-rest/powersearch/names?address="

        'GetAddress SEttings
        SystemSettings.UseGetAddress = False
        SystemSettings.GetAddressIOAPIKey = ""

        'Generic Payment Settings 'used as Bu for x-pay
        SystemSettings.Payment_InstitutionID = ""
        SystemSettings.Payment_Secret = ""
        SystemSettings.Payment_SubmitURL = ""
        'Live : https://payments.coventry.gov.uk/public/XPay.aspx?
        'Test : https://testpay.coventry.gov.uk/public/XPay.aspx?

        'WorldPay-specific Settings
        SystemSettings.WorldPay_TestMode = "100"
        'See info in http://support.worldpay.com/support/kb/bg/pdf/181450-basic-integration-f.pdf

        'RealEx-specific Settings
        SystemSettings.RealEx_Account = ""


        'X-Pay Specific settings
        SystemSettings.PaymentType = ""
        SystemSettings.CcEmail = ""

        'Verify Email for new acccounts
        SystemSettings.ShouldVerifyEmail = True

        'Address provider to use (one only)
        SystemSettings.UseAFD = False
        SystemSettings.UseAFDEvolution = True
        SystemSettings.UseQASProOnDemand = False

        'Payment Provider to use (one only)
        SystemSettings.UseCapita = False
        SystemSettings.UseCivica = False
        SystemSettings.UsePayPal = False
        SystemSettings.UseRealEx = False
        SystemSettings.UseWorldPay = False
        SystemSettings.UseBucksNet = False
        SystemSettings.UseXPay = False

        'Civica-specific settings
        SystemSettings.Civica_Account = ""
        SystemSettings.Civica_FundCode = ""
        SystemSettings.Civica_AccountReference = ""

        'Capita-specific settings
        SystemSettings.CapitaPaymentsV2 = True

        ''CCCPS-75837: CCCFileUpload control Porperties
        SystemSettings.MaxAllowedFileSize = 4000
        SystemSettings.SupportedFileTypes = ".jpg, .jpeg, .png, .pdf, .gif, .pdf, .doc, .docx" ''Change this according to your need

        ''CCCPS-75553: Following properties need to be set to enable User Locking mechanism.
        SystemSettings.AllowedInvalidPasswordAttempts = 3 ''Number of attempts after which user will be locked out.
        SystemSettings.AutoUnlockUserAfter = 360 ''User will be unlocked after specified minutes here.

        SystemSettings.SaveForLater = False ''CCCPS-80182: New setting to control Save for Later feature.

    End Sub


</script>
