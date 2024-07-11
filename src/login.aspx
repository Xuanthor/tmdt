<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Title="Login" Inherits="login" MasterPageFile="~/MasterPage.master" %>

<%@ Register src="Banner.ascx" tagname="Banner" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .loadingBody {
            opacity: 0;
            position: relative;
        }
        .loadingOut {
            text-align: center;
        }
        .loadingIcon {
            width: 32px;
            height: 32px;
        }
        .login-form {
            max-width: 400px;
            margin: auto;
        }
        .login-form table {
            width: 100%;
        }
        .login-form .ant-input {
            width: 100%;
        }
        .login-form .ant-btn {
            width: 100%;
        }
    </style>
    <script>
        function loadingOp() {
            $(document).ready(function () {
                $('.loadingBody').animate({ opacity: 0 }, 0);
                $('.loadingOut').fadeIn(0);
                $('.loadingOut').fadeOut(2400);
                $('.loadingBody').animate({ opacity: 1 }, 2500);
            });
        }

        function loadingIconVisible() {
            if (Page_ClientValidate("AllValidationGroup")) {
                document.getElementById('<%=loadingIcon.ClientID%>').style.opacity = 1;
                document.getElementById('<%=ButtonLogin.ClientID%>').style.cursor = "not-allowed";
            }
        }

        loadingOp();
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContentHolder" Runat="Server">
    <uc1:Banner ID="Banner1" runat="server" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="loadingOut ant-alert ant-alert-info">
        <p>Please Wait While Loading....</p>
    </div>
    <div class="loadingBody">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="login-form ant-card ant-card-bordered">
                    <div class="ant-card-head">
                        <div class="ant-card-head-title"><strong>Login</strong></div>
                    </div>
                    <div class="ant-card-body">
                        <form>
                            <div class="ant-form-item">
                                <label class="ant-form-item-label">User name</label>
                                <div class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxUN" runat="server" CssClass="ant-input" placeholder="Username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUN" ErrorMessage="Username is required" CssClass="ant-form-item-explain" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="ant-form-item">
                                <label class="ant-form-item-label">Password</label>
                                <div class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxPass" runat="server" TextMode="Password" CssClass="ant-input" placeholder="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxPass" ErrorMessage="Password is required" CssClass="ant-form-item-explain" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="ant-form-item">
                                <div class="ant-form-item-control">
                                    <asp:CheckBox ID="RememberMeCheckBox" runat="server" Text="Remember Me" CssClass="ant-checkbox" />
                                </div>
                            </div>
                            <div class="ant-form-item">
                                <div class="ant-form-item-control">
                                    <asp:Button ID="ButtonLogin" runat="server" Text="Login" OnClientClick="loadingIconVisible();" OnClick="ButtonLogin_Click" />
                                    <span>
                                        <asp:Image ID="loadingIcon" runat="server" ImageUrl="~/icon/loadingIcon.gif" AlternateText="Loading..." CssClass="loadingIcon" />
                                    </span>
                                </div>
                            </div>
                            <div class="ant-form-item">
                                <a href="Registration.aspx">Create a new account</a>
                            </div>
                            <div class="ant-form-item">
                                <asp:Label ID="InfoLabel" runat="server" CssClass="ant-form-item-explain"></asp:Label>
                            </div>
                        </form>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
