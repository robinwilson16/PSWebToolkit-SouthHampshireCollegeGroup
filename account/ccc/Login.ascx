<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Login.ascx.vb" Inherits="account_ccc_Login" %>

<%--<br /><br />
<ol class="breadcrumb">
    <li><a href="default.aspx">Home</a></li>
    <li class="active">Login</li>
</ol>--%>



<br /><br />

<div class="form-field-section grey">
    <h2 class="app-title">Login Page</h2>
        <div>         
            
               
                
                    <div class=" form-group">
                         <label for="email" class="label2 textfieldlabelrequired">Email</label>
                        <input type="email" id="email" class="form-control" name="pre[email]" placeholder="Your E-mail here..." autocomplete="off" required autofocus  />
                    </div>                   
                    <div class=" form-group">
                        <label for="password" class="label2 textfieldlabelrequired">Password</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Your password here..." autocomplete="off" required />
                    </div>
                    <div class=" form-group">
                        <p runat="server" id="errtext" style="color:red"></p>
                        <asp:HyperLink ID="lnkReSend" visible="false" runat="server" ClientIDMode="Static" NavigateUrl="~/webenrolment.aspx?page=~/account/ccc/AccessPending.ascx">Click here to request a new verification email.</asp:HyperLink>
                    </div>
                     <div class=" form-group">                  
                       <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="button" />
                    </div>
            <div class="form-group">
                    <asp:HyperLink ID="lnkReset" runat="server" ClientIDMode="Static" NavigateUrl="~/webenrolment.aspx?page=~/account/ccc/PasswordReset.ascx">If you have forgotten your password, click here.</asp:HyperLink>
                    
                </div>


            <div class="form-group">
                    <asp:HyperLink ID="HyperLink1" runat="server" ClientIDMode="Static" NavigateUrl="~/webenrolment.aspx?page=~/account/ccc/Register.ascx">To Register, click here.</asp:HyperLink>
                    
                </div>


               
                    </div>

</div>


<style>
    .label2 {display:inline-block;width:200px;}
</style>