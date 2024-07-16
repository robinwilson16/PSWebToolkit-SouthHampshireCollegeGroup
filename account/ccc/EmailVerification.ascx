<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EmailVerification.ascx.vb" Inherits="account_ccc_EmailVerification" %>

<%--<br /><br />
<ol class="breadcrumb">
    <li><a href="default.aspx">Home</a></li>
    <li class="active">Email Verification</li>
</ol>--%>



<br /><br />

<div class="form-field-section grey">
    <h2 class="app-title">Email Verification</h2>
        <div>         
            
               
            
 <div>
             <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />
                <asp:button ID="ResendVerification" runat="server" Text="Resend Verification Code" Visible="false" CssClass="button"/>
    </div><br /><br />
                        <div class="alert alert-success alert-dismissable" runat="server" visible="false" id="altSuccess">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Success!</strong>We've sent an email to your inbox, check it for the link to verify your account
</div>
            </div>

    </div>