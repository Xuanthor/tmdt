<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="chat.aspx.cs" Inherits="chat" MasterPageFile="~/MasterPage.master" MaintainScrollPositionOnPostback="true" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .OnlineCSS {
            position: relative;
            border: 0px solid #52c41a;
            height: 7px;
            width: 7px;
            border-radius: 50%;
            background-color: #52c41a;
            float: right;
            margin-top: 3%;
        }

        .OfflineCSS {
            position: relative;
            border: 0px solid #878080;
            height: 7px;
            width: 7px;
            border-radius: 50%;
            background-color: #c2bbbb;
            float: right;
            margin-top: 3%;
        }

        .SenderClass {
            background: #1890ff;
            color: #ffffff;
            border: 1px solid #1890ff;
        }

        .ReceiverClass {
            background: #faad14;
            color: #ffffff;
            border: 1px solid #faad14;
        }

        .MainChatListClass {
            padding: 5px;
            width: 250px;
            position: relative;
            border-radius: 5px;
            word-wrap: break-word;
            margin-top: 5px;
        }

        .SenderClass::after {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            right: 0;
            top: 0px;
            border: 10px solid;
            border-color: #1890ff transparent transparent #1890ff;
        }

        .ReceiverClass::after {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: 0;
            top: 3px;
            border: 10px solid;
            border-color: #faad14 #faad14 transparent transparent;
        }

        .chat-container {
            max-height: 520px;
            overflow-y: auto;
            padding: 5px;
        }
    </style>
    <script>
        function playSound() {
            document.getElementById("audioId").play();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContentHolder" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick">
            </asp:Timer>
            <asp:Panel ID="Panel2" runat="server">
                <div>
                    <h5 class="ant-alert ant-alert-success" style="text-align: center">
                        <span>Hello <%=Server.HtmlEncode(CurrentSender.Text).ToUpper()%> !!</span>
                    </h5>
                    <br />
                     <asp:Button ID="Logout" runat="server" Text="Logout" OnClick="logout_Click" />
                </div>
            </asp:Panel>
            <asp:Panel ID="Panel1" runat="server">
                <div class="chat-container">
                    <asp:Label ID="CurrentSender" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:Label ID="CurrentRecevier" runat="server" Text="" Visible="false"></asp:Label>

                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:RegistrationConnectionString %>' SelectCommand="SELECT [MsgSender] FROM [MsgTable] WHERE (([RecevierSeen] = 0) AND ([MsgReceiver] = @MsgReceiver))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="CurrentSender" PropertyName="Text" Name="MsgReceiver" Type="String"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="ant-card ant-card-bordered ant-card-danger">
                        <div class="ant-card-head">
                            <div class="ant-card-head-title">Unread Messages <asp:Label ID="UnreadMsgCountLabel" runat="server" CssClass="ant-badge-count"></asp:Label></div>
                        </div>
                        <div class="ant-card-body">
                            <asp:DataList ID="DataList4" runat="server" DataSourceID="SqlDataSource3" Width="100%">
                                <ItemTemplate>
                                    <asp:LinkButton Text='<%# Eval("MsgSender") %>' runat="server" ID="MsgSenderLabel" OnClick="UsernameLabel_Click" CssClass="ant-list-item" />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:RegistrationConnectionString %>' SelectCommand="SELECT [Username] FROM [UserDatabase] WHERE ([Username] <> @Username) AND OnlineStatus = 1">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="CurrentSender" PropertyName="Text" Name="Username" Type="String"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="ant-card ant-card-bordered ant-card-success">
                        <div class="ant-card-head">
                            <div class="ant-card-head-title">Online Users</div>
                        </div>
                        <div class="ant-card-body">
                            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
                                <ItemTemplate>
                                    <div class="ant-list-item">
                                        <asp:LinkButton Text='<%# Eval("Username") %>' runat="server" ID="UsernameLabel" OnClick="UsernameLabel_Click" />
                                        <div class="OnlineCSS"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:RegistrationConnectionString %>' SelectCommand="SELECT [Username] FROM [UserDatabase] WHERE ([Username] <> @Username) AND (OnlineStatus = 0  or OnlineStatus is null)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="CurrentSender" PropertyName="Text" Name="Username" Type="String"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div class="ant-card ant-card-bordered ant-card-info">
                        <div class="ant-card-head">
                            <div class="ant-card-head-title">Offline Users</div>
                        </div>
                        <div class="ant-card-body">
                            <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSource2" Width="100%">
                                <ItemTemplate>
                                    <div class="ant-list-item">
                                        <asp:LinkButton Text='<%# Eval("Username") %>' runat="server" ID="UsernameLabel" OnClick="UsernameLabel_Click" />
                                        <div class="OfflineCSS"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger EventName="Tick" ControlID="Timer1" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <h4 style="text-align: center" class="ant-alert ant-alert-info"><%= GetWelcomeBanner(CurrentRecevier.Text)%></h4>
            </div>
            <asp:Panel runat="server" ID="chatPanel">
                <div style="vertical-align: middle; min-height: 480px;" class="pre-scrollable">
                    <asp:DataList ID="DataList2" runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" RepeatLayout="Table">
                        <ItemTemplate>
                            <div class="<%# GetStyleForMsgList(Eval("MsgSender").ToString()) %>  MainChatListClass">
                                <asp:Label ID="Label1" runat="server" Text='<%# GetPerfactName(Eval("MsgSender").ToString()) %>'></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("ChatMsg") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="padding: 5px 15px 5px 5px">
        <asp:Panel ID="MsgPanel" runat="server" DefaultButton="sendBTN">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <script>
                        function loadingIconVisible() {
                            document.getElementById('<%=LoadingImage.ClientID%>').style.opacity = 1;
                        }
                    </script>
                    <div>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:TextBox ID="MSGTextBox" runat="server" placeholder="Enter message" CssClass="ant-input" Width="100%"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="sendBTN" runat="server" Text="Send" OnClick="sendBTN_Click" OnClientClick="loadingIconVisible()" />
                                </td>
                            </tr>
                        </table>
                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/icon/loadingIcon.gif" ImageAlign="Right" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
    </div>
</asp:Content>
