﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DoPasswordReset.ascx.vb" Inherits="account_ccc_DoPasswordReset" %>

<%--<br /><br />
<ol class="breadcrumb">
    <li><a href="default.aspx">Home</a></li>
    <li class="active">Reset Password</li>
</ol>--%>


<br /><br />

<div class="form-field-section grey">
                        <b>To change your password, enter your new password below</b>
                                     
                    <div class=" form-group">
                        <label for="passwordnew" class="label2 ">Change Password</label>
                        <input type="password" id="passwordnew" name="passwordnew" class="form-control" placeholder="New password here..." autocomplete="off"   />
                    </div>
                    <div class=" form-group">
                        <label for="password_mirror" class="label2 ">Retype New Password</label>
                        <input type="password" id="password_mirror" name="password_mirror" class="form-control"  placeholder="Retype your new password..." autocomplete="off"   oninput="check(this)"/>
                    </div>
                   
                    <div class=" form-group">
                        <p runat="server" id="errtext" style="color:red"></p>
                    </div>
                    <div class=" form-group">
                        
                       <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="button" />
                        
                    </div>
</div>
 <div class=" form-group" style="text-align:center;">
             <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />
               </div>


<script>
    function check(input) {
        if (input.value !== $("#passwordnew").val()) {
            input.setCustomValidity('Password does not match.');
        } else {
            // input is fine -- reset the error message
            input.setCustomValidity('');
        }
    }

</script>