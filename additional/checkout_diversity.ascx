<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_diversity.ascx.vb" Inherits="checkout_diversity" %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>
<%@ Register Src="~/webcontrols/StudentSignature.ascx" TagPrefix="uc1" TagName="StudentSignature" %>



<div class="form-field-section grey">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center"
        DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none">


        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Course Name">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Start Date"
                HtmlEncode="False">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="End Date"
                HtmlEncode="False">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="SiteDescription" HeaderText="Site" />
            <asp:BoundField DataField="TotalFeeAmount" HeaderText="Total Fees" DataFormatString="{0:c}" Visible="false">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
        </Columns>
        <RowStyle CssClass="searchgridcell" />
        <HeaderStyle CssClass="searchgridheader" />
        <EmptyDataTemplate>
            <p>
                No Actual Courses Found for you to Enrol on / Apply for, please try searching for 
                    another course.
            </p>
        </EmptyDataTemplate>
    </asp:GridView>
</div>
 


<div class="form-field-section grey">    
    <h2 class="app-title">Your Details</h2>
    <hr />
    <br />
       
      <p class="textfieldlabelrequired"> Denotes a mandatory field : </p>

    <br />
    <br />

    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Title" ID="StudentEnrolmentField3" runat="server" IsRequired="true" LabelWidth="300" />
    </div>


    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" ID="StudentEnrolmentField1" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="First Name (Given name)" />
    </div>
    <p>This should be your legal name. This will then be used for all our communications, official documents (e.g. certificates), and correspondence</p>
   

    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" ID="StudentEnrolmentField10" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="Last Name (Family name)" />
    </div>

  <%--  <div class=" form-group">
        <cc1:StudentEnrolmentField ID="datepicker" runat="server" IsRequired="true" StudentEnrolmentFieldType="DateOfBirth" LabelWidth="200" ClientIDMode="Static" />
    </div>--%>


    <p class="textfieldlabelrequired">Gender </p>
    <asp:DropDownList ID="Sex" runat="server" CssClass="textfield form-control">
        <asp:ListItem Value="" Text="--please select--"></asp:ListItem>
        <asp:ListItem Value="M" Text="Male"></asp:ListItem>
        <asp:ListItem Value="F" Text="Female"></asp:ListItem>
    </asp:DropDownList>

    <%--    <p class="textfieldlabelrequired">Date of Birth</p>

    <asp:TextBox ID="DoB" runat="server" AutoPostBack="true" CssClass="form-control" type="date"></asp:TextBox>
    <br />--%>




    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EthnicGroupID" ID="fldEthnic" runat="server" LabelWidth="300" IsRequired="true" CustomCaption="Ethnic Origin" />
    </div>


      <div class="form-input">
         <p class="textfieldlabelrequired">Country of residence</p>
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="CountryID" ID="fldCountryID" runat="server" LabelWidth="0" IsRequired="false" CustomCaption="What is your country of residence?" />
        </div>

        <div class="form-input">
               <span class="textfieldlabelrequired">Please select your country of National Identity</span>
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="NationalityID" ID="fldNationalityID" runat="server" LabelWidth="300" IsRequired="false"
            CustomCaption="Nationality" />
            </div>

          <div class="form-input">
            <span class="textfieldlabelrequired">Are you an Asylum Seeker</span>
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentInternationalDetailUserDefined1" ID="StudentEnrolmentField28" runat="server" LabelWidth="0" IsRequired="false" CustomCaption="Are you an Asylum Seeker?" CustomFieldType="Lookup" />
        </div>

          <div class="form-input">
            <span class="textfieldlabelrequired">Are you a Refugee</span>
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentInternationalDetailUserDefined2" ID="StudentEnrolmentField31" runat="server" LabelWidth="0" IsRequired="false" CustomCaption="Are you a Refugee?" CustomFieldType="Lookup" />
        </div>

     


    <p>We collect information relating to special educational needs, disabilities and additional support so our learning support team can work with you to ensure that you receive the appropriate help and advice to achieve your full potential</p>

    <div class="form-input">
        <span class="textfieldlabelrequired">Do you have any disabilities or learning difficulties?</span>
        <asp:RadioButtonList runat="server" ID="rdoLearnDiff" CssClass="form-input">
            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="2"></asp:ListItem>

        </asp:RadioButtonList>

    </div>

    <div class="disFields">
        <div class="form-input">
            
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField2" CustomCaption="Main Disability/Learning Difficulty" StudentEnrolmentFieldType="DisabilityCategory1ID" LabelWidth="300" />
        </div>
        <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField4" CustomCaption="Please identify any additional Disabilities / Learning Difficulties" StudentEnrolmentFieldType="DisabilityCategory2ID" LabelWidth="300" />
        </div>






        





        <p class="textfieldlabelrequired">Have you previously had exam concessions?</p>
        <asp:RadioButtonList ID="rdoMobility" runat="server">

            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="0"></asp:ListItem>
        </asp:RadioButtonList>

        <div class="displaynone">

            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined6" ID="fldMobility" runat="server" LabelWidth="0" CustomFieldType="TickBox" />


        </div>



        <br />
        <br />

        <p class="textfieldlabelrequired">Did you receive additional support at school?</p>
        <asp:RadioButtonList ID="AdditionalSupport" runat="server">

            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="0"></asp:ListItem>
        </asp:RadioButtonList>

        <div class="displaynone">

            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="HasSpecialEducationNeeds" ID="StudentEnrolmentField6" runat="server" LabelWidth="400" />


        </div>



        <br />
        <br />


        <%-- <p class="textfieldlabelrequired">Did you receive additional support for exams at school?</p>
    <asp:RadioButtonList ID="ExamDis" runat="server">

        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
        <asp:ListItem Text="No" Value="0"></asp:ListItem>
    </asp:RadioButtonList>

    <div class="displaynone">

        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ALSRequested" ID="StudentEnrolmentField13" runat="server" LabelWidth="400" />


    </div>
        --%>





        <p class="textfieldlabelrequired">Do you have an educational health care plan (EHCP)?</p>
        <asp:RadioButtonList ID="HasEHCP" runat="server">

            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="0"></asp:ListItem>
        </asp:RadioButtonList>

        <div class="displaynone">

            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="HasEducationHealthCarePlan" ID="StudentEnrolmentField14" runat="server" LabelWidth="400" />


        </div>
        <br />


       <%-- <h4>Please provide any extra information that can help us to help you, like if you need assistance in an emgergency, help with your exams or interview support</h4>

        <div class="form-group">
            <cc1:StudentEnrolmentField runat="server" StudentEnrolmentFieldType="StudentDetailUserDefined11" CustomCaption="Notes" CustomFieldType="other" ClientIDMode="Static" />
            <p style="text-align: right; font-size: 8pt;" id="charsLeft2">255 characters left</p>
        </div>--%>

    </div>

    <br />
    <br />


    <h2 class="app-title">Application Support</h2>



    <p class="textfieldlabelrequired">Are you a carer? </p>
    <asp:RadioButtonList ID="NotHEYoungCarer" runat="server" EnableViewState="true">

        <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
        <asp:ListItem Value="2" Text="No"></asp:ListItem>

    </asp:RadioButtonList>

    <br />
    <br />

    <div class="displaynone">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="YoungCarer" ID="fldCare" runat="server" IsRequired="false" LabelWidth="300" CustomCaption="Young Carer" Enabled="True" CustomFieldType="TickBox" />
    </div>



    <script>


        $(document).ready(function () {




            var rdo = document.getElementsByName("<%= NotHEYoungCarer.UniqueID%>")
            if (rdo[0].checked) {
                $('#ctl00_MainContentPlaceholder_ctl00_fldCare_chkYoungCarer').prop('checked', true);
            }
            else {
                $('#ctl00_MainContentPlaceholder_ctl00_fldCare_chkYoungCarer').prop('checked', false);
            }

            // Set EU Fields visibility when 'Yes' radio button is clicked
            var RadioButtonListEU = document.getElementById("<%= NotHEYoungCarer.ClientID%>")
            RadioButtonListEU.onchange = function () {
                var rdo = document.getElementsByName("<%= NotHEYoungCarer.UniqueID%>")
                if (rdo[0].checked) {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldCare_chkYoungCarer').prop('checked', true);
                }
                else {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldCare_chkYoungCarer').prop('checked', false);
                }



            };
        });

    </script>


    <div id="careleaverQ19" runat="server" visible="false">
        <p class="textfieldlabelrequired">Have you recently left Care?   </p>
        <asp:RadioButtonList ID="NotHECareLeaver" runat="server" EnableViewState="true">

            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
            <asp:ListItem Value="2" Text="No"></asp:ListItem>

        </asp:RadioButtonList>


        <div class="displaynone">
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="CareLeaver" ID="fldCareLeaver" runat="server" IsRequired="false" LabelWidth="300" CustomCaption="Care Leaver" Enabled="True" CustomFieldType="TickBox" />
        </div>



        <script>


            $(document).ready(function () {




                var rdo = document.getElementsByName("<%= NotHECareLeaver.UniqueID%>")
                if (rdo[0].checked) {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldCareLeaver_chkCareLeaver').prop('checked', true);
                }
                else {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldCareLeaver_chkCareLeaver').prop('checked', false);
                }

                // Set EU Fields visibility when 'Yes' radio button is clicked
                var RadioButtonListEU = document.getElementById("<%= NotHECareLeaver.ClientID%>")
                RadioButtonListEU.onchange = function () {
                    var rdo = document.getElementsByName("<%= NotHECareLeaver.UniqueID%>")
                    if (rdo[0].checked) {
                        $('#ctl00_MainContentPlaceholder_ctl00_fldCareLeaver_chkCareLeaver').prop('checked', true);
                    }
                    else {
                        $('#ctl00_MainContentPlaceholder_ctl00_fldCareLeaver_chkCareLeaver').prop('checked', false);
                    }



                };
            });

        </script>

    </div>

    <div id="InCare1618" runat="server" visible="false">
        <p class="textfieldlabelrequired">Are you currently in care?   </p>
        <asp:RadioButtonList ID="rdoLookedAfter" runat="server" EnableViewState="true">

            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
            <asp:ListItem Value="2" Text="No"></asp:ListItem>

        </asp:RadioButtonList>


        <div class="displaynone">
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="LookedAfter" ID="fldLookedAfter" runat="server" IsRequired="false" LabelWidth="300" CustomCaption="Looked after" Enabled="True" CustomFieldType="TickBox" />
        </div>



        <script>


            $(document).ready(function () {




                var rdo = document.getElementsByName("<%= rdoLookedAfter.UniqueID%>")
                if (rdo[0].checked) {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldLookedAfter_chkLookedAfter').prop('checked', true);
                }
                else {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldLookedAfter_chkLookedAfter').prop('checked', false);
                }

                // Set EU Fields visibility when 'Yes' radio button is clicked
                var RadioButtonListEU = document.getElementById("<%= rdoLookedAfter.ClientID%>")
                RadioButtonListEU.onchange = function () {
                    var rdo = document.getElementsByName("<%= rdoLookedAfter.UniqueID%>")
                    if (rdo[0].checked) {
                        $('#ctl00_MainContentPlaceholder_ctl00_fldLookedAfter_chkLookedAfter').prop('checked', true);
                    }
                    else {
                        $('#ctl00_MainContentPlaceholder_ctl00_fldLookedAfter_chkLookedAfter').prop('checked', false);
                    }



                };
            });

        </script>
        </div>

      
<%--      <p class="textfieldlabelrequired">Which best Describes your household situation</p>

    <asp:RadioButtonList ID="hhs" runat="server">
        <asp:ListItem Value="1" Text="No household member is in employment and the household includes one or more dependent children"></asp:ListItem>
        <asp:ListItem Value="2" Text="No household member is in employment and the household does not include any dependent children"></asp:ListItem>
        <asp:ListItem Value="3" Text="I live in a single adult household with dependent children"></asp:ListItem>
        <asp:ListItem Value="13" Text="I live in a single adult household with dependent children, and also no member of the household is in employment"></asp:ListItem>
        <asp:ListItem Value="98" Text="I do not wish to say"></asp:ListItem>
        <asp:ListItem Value="99" Text="None of these apply to me"></asp:ListItem>
    </asp:RadioButtonList>
--%>



        
      <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined5" ID="StudentEnrolmentField37" runat="server" IsRequired="false" LabelWidth="300" CustomCaption="Annual household income" CustomFieldType="Lookup" />
    </div>
        
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentFirstLanguageID" ID="fldLanguage" runat="server" IsRequired="true" LabelWidth="400" CustomCaption="What is your first language spoken at home?" Enabled="True" CustomFieldType="Lookup" />
    </div>
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined2" ID="StudentEnrolmentField38" runat="server" IsRequired="true" LabelWidth="300" CustomFieldType="Lookup" CustomCaption="Religion" />
    </div>
        
             <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined3" ID="StudentEnrolmentField39" runat="server" IsRequired="true" LabelWidth="300" CustomFieldType="Lookup" CustomCaption="Sexual orientation" />
    </div>

    <p>This is about who you are attracted to</p>

    <ul>
	<li>Straight/Hetrosexual = attracted to people of a different sex to you</li>
	<li>Gay = attracted to people of the same sex as you (used by men and women)</li>
	<li>Lesbian = attracted to people of the same sexa as you (used by women)</li>
	<li>Bisexual = attracted to both men and women</li>
	<li>Other = this includes different sexual orientations like asexual, pansexual</li>
	<li>Prefer not to say = choose this if you do not want to answer this question</li>
</ul>
     <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined9" ID="StudentEnrolmentField40" runat="server" IsRequired="true" LabelWidth="300" CustomFieldType="Lookup" CustomCaption="What is your Gender Identity ?" />
    </div>
   
    <p>Some of us have a gender which is different from the gender that was registered when we were born. Some of us feel like we are male, female or neither. Please let us know if your legal gender status has been changed. </p>

    <ul>
        <li>Agender = A person who does not identify as any gender</li>
         <li>Female = female gender identity is the same as the sex assigned at birth (cisgender woman)</li>
         <li>Male = male gender identity is the same as the sex assigned at birth (cisgender man)</li>
         <li>Non-binary = A person whose gender identity is neither male nor female</li>
         <li>Other gender = A person who describes their gender identity in another way e.g bi-gender, intersex</li>
         <li>Trans female = female gender identity but was assigned male at birth (transgender woman)</li>
         <li>Trans male – male gender identity but was assigned female at birth (transgender man)</li>
    </ul>


           <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="PreferredPronounID" ID="StudentEnrolmentField5" runat="server" IsRequired="false" LabelWidth="300" CustomFieldType="Lookup" CustomCaption="Perferred Pronoun" />
    </div>


   




    <br />
    <br />


 



    
    <p class="textfieldlabelrequried">SHCG is committed to protecting the rights of individuals in line with Data Protection legislation. In ticking the box below, I am consenting to my data being processed in accordance with the SHCG privacy notice. (<a href="https://www.SHCG.ac.uk/privacy-notice/" target="_blank">https://www.SHCG.ac.uk/privacy-notice/</a>). </p>

   <%-- <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField16" CustomCaption="Data processing consent" StudentEnrolmentFieldType="SentMarketingInfo" LabelWidth="400" IsRequired="true" />
    </div>--%>

    <p class="textfieldlabelrequired">
       Please confirm the data processing consent 
    </p>
    <asp:CheckBox ID="DPC" runat="server" />


    <br />
    <hr />







    <cc1:CCCButton ID="btnBack" runat="server" Text="Back" LinkResource="checkout_home_aspx" CssClass="button" visible="false"/>
    <cc1:CCCButton ID="btnContinue" runat="server" Text="Continue" CausesValidation="true" CssClass="button" />

</div>
<br />
<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />


<script>

    $(document).ready(function () {
        //disability stuff
        $('.disFields').hide();

        // Hide or Show Learning Difficulty 
        var rdo = document.getElementsByName("<%= rdoLearnDiff.UniqueID%>")
        if (rdo[0].checked) {
            $(".disFields").show();
        }
        else {
            $(".disFields").hide();
        }

        // Set Learning Difficulty Fields visibility when Learning Difficulty 'Yes' radio button is clicked
        var rdoLearnDiff = document.getElementById("<%= rdoLearnDiff.ClientID%>")
        rdoLearnDiff.onchange = function () {
            var rdo = document.getElementsByName("<%= rdoLearnDiff.UniqueID%>")
            if (rdo[0].checked) {
                $(".disFields").slideDown();
            }
            else {
                $(".disFields").slideUp();
            }


            $("#txtDisabilityNotes").keyup(function () {
                var charsLeft = (255 - $(this).val().length);
                $('#charsLeft2').text(charsLeft + ' characters left');

            });
        };
    });

</script>

<script>

    $("#<%= btnContinue.ClientID %>").click(function (e) {
        //$(this).prop("disabled", "disabled");
        alert("Please click “OK” to close this window and we will then process your  request. Please do not press continue again");
        return true;
    });


</script>