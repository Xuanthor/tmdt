<%@ Page Language="C#" Title="Registration" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" MasterPageFile="~/MasterPage.master" %>

<%@ Register Src="~/Banner.ascx" TagPrefix="uc1" TagName="Banner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/antd/4.15.1/antd.min.css" rel="stylesheet" />

    <script>
        function loadingIconVisible() {
            if (Page_ClientValidate("AllValidationGroup")) {
                document.getElementById('<%=LoadingImage.ClientID%>').style.opacity = 1;
                document.getElementById('<%=submit.ClientID%>').style.cursor = "not-allowed";
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContentHolder" Runat="Server">
    <uc1:Banner runat="server" ID="Banner" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <div class="ant-card">
                    <div class="ant-card-head">
                        <div class="ant-card-head-title">Registration Form</div>
                    </div>
                    <div class="ant-card-body">
                        <asp:Label ID="InfoLabel" runat="server" CssClass="ant-alert ant-alert-info" Visible="false"></asp:Label>
                        <table class="ant-table">
                            <tr class="ant-form-item">
                                <td class="ant-form-item-label">Username:</td>
                                <td class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxUN" runat="server" CssClass="ant-input"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="ant-form-explain" ErrorMessage="Username is invalid. A-Z , 0-9 , Underscore &amp; hyphen allowed" ControlToValidate="TextBoxUN" ValidationExpression="^[a-z0-9_-]+$" ValidationGroup="AllValidationGroup"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUN" CssClass="ant-form-explain" ErrorMessage="Username is required" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr class="ant-form-item">
                                <td class="ant-form-item-label">E-mail:</td>
                                <td class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="ant-input"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxEmail" CssClass="ant-form-explain" ErrorMessage="Email is required" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBoxEmail" CssClass="ant-form-explain" ErrorMessage="Enter a valid Email address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="AllValidationGroup"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr class="ant-form-item">
                                <td class="ant-form-item-label">Password:</td>
                                <td class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxPass" runat="server" CssClass="ant-input" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxPass" CssClass="ant-form-explain" ErrorMessage="Password is required" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr class="ant-form-item">
                                <td class="ant-form-item-label">Confirm Password:</td>
                                <td class="ant-form-item-control">
                                    <asp:TextBox ID="TextBoxRPass" runat="server" CssClass="ant-input" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBoxRPass" CssClass="ant-form-explain" ErrorMessage="Confirm Password is required" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" CssClass="ant-form-explain" ErrorMessage="Both passwords should be the same" ControlToCompare="TextBoxPass" ControlToValidate="TextBoxRPass" ValidationGroup="AllValidationGroup"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr class="ant-form-item">
                                <td class="ant-form-item-label">Country:</td>
                                <td class="ant-form-item-control">
                                    <asp:DropDownList ID="DropDownListCountry" runat="server" CssClass="ant-select">
                                        <asp:ListItem>Select Country</asp:ListItem>
                                        <asp:ListItem>India</asp:ListItem>
                                        <asp:ListItem>USA</asp:ListItem>
                                        <asp:ListItem>UK</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropDownListCountry" CssClass="ant-form-explain" ErrorMessage="Country is required" InitialValue="Select Country" ValidationGroup="AllValidationGroup"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr class="ant-form-item">
                                <td></td>
                                <td class="ant-form-item-control">
                                    <asp:Button ID="submit" runat="server" OnClick="submit_Click" Text="Submit"  OnClientClick="loadingIconVisible()" BackColor="#CCCCCC" ForeColor="Black" />
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/icon/loadingIcon.gif" CssClass="ant-spin" Style="margin-left: 20px;" />
                                </td>
                                <td><a href="login.aspx">Already have an account?</a></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server" Visible="false">
                <div class="ant-alert ant-alert-success" role="alert">
                    <asp:Label ID="ConfirmationLevel" runat="server" Text="<p style='text-align: center'>Registration Successfully Done...!!! <br /><a href='login.aspx'>Login from here</a></p>" Visible="true" Font-Size="X-Large" Font-Bold="True"></asp:Label>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
