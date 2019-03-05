<GameFile>
  <PropertyGroup Name="Chat" Type="Layer" ID="12758a9c-5a08-4879-85c9-7af5eb9b56e8" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Layer" Tag="346" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="Panel_Bg" ActionTag="359666301" Tag="296" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-140.0000" RightMargin="-140.0000" TopMargin="-120.0000" BottomMargin="-120.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="153" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="1560.0000" Y="960.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.2188" Y="1.3333" />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Img_ChatBg" ActionTag="750470889" Tag="351" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="694.8680" RightMargin="2.1320" TopMargin="6.9440" BottomMargin="3.0560" TouchEnable="True" Scale9Width="497" Scale9Height="690" ctype="ImageViewObjectData">
            <Size X="583.0000" Y="710.0000" />
            <Children>
              <AbstractNodeData Name="Btn_Send" ActionTag="1550062205" Tag="358" IconVisible="False" LeftMargin="337.5000" RightMargin="104.5000" TopMargin="635.5000" BottomMargin="11.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="141.0000" Y="63.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="408.0000" Y="43.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6998" Y="0.0606" />
                <PreSize X="0.2419" Y="0.0887" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="MarkedSubImage" Path="image/Chat/btn_send.png" Plist="image/Chat/chat.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Record" ActionTag="-1498578162" Tag="168" IconVisible="False" LeftMargin="11.0000" RightMargin="109.6913" TopMargin="33.3089" BottomMargin="106.5067" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="462.3087" Y="570.1844" />
                <Children>
                  <AbstractNodeData Name="ListVw_Record" ActionTag="2126229943" Tag="171" IconVisible="False" LeftMargin="0.0052" RightMargin="4.6805" TopMargin="16.5885" BottomMargin="1.3011" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ScrollDirectionType="0" DirectionType="Vertical" ctype="ListViewObjectData">
                    <Size X="457.6230" Y="552.2948" />
                    <Children>
                      <AbstractNodeData Name="Panel_Chat" ActionTag="-595593732" Tag="174" IconVisible="False" RightMargin="-1.3770" BottomMargin="421.2948" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="459.0000" Y="131.0000" />
                        <Children>
                          <AbstractNodeData Name="Img_NickBg" ActionTag="-689478079" Tag="100" IconVisible="False" LeftMargin="9.5000" RightMargin="324.5000" TopMargin="11.0000" BottomMargin="72.0000" LeftEage="19" RightEage="17" Scale9OriginX="19" Scale9Width="81" Scale9Height="48" ctype="ImageViewObjectData">
                            <Size X="125.0000" Y="48.0000" />
                            <Children>
                              <AbstractNodeData Name="Text_Nickname" ActionTag="1547784291" Tag="176" IconVisible="False" PositionPercentYEnabled="True" RightMargin="2.0000" TopMargin="7.0000" BottomMargin="7.0000" FontSize="30" LabelText="哈哈哈哈" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                                <Size X="123.0000" Y="34.0000" />
                                <AnchorPoint ScaleY="0.5000" />
                                <Position Y="24.0000" />
                                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                                <CColor A="255" R="0" G="0" B="0" />
                                <PrePosition Y="0.5000" />
                                <PreSize X="0.9840" Y="0.7083" />
                                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                                <OutlineColor A="255" R="255" G="0" B="0" />
                                <ShadowColor A="255" R="110" G="110" B="110" />
                              </AbstractNodeData>
                            </Children>
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="72.0000" Y="96.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.1569" Y="0.7328" />
                            <PreSize X="0.2723" Y="0.3664" />
                            <FileData Type="MarkedSubImage" Path="image/Chat/nick_bg1.png" Plist="image/Chat/chat.plist" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Img_Content_Bg" ActionTag="1316717134" Tag="438" IconVisible="False" LeftMargin="141.0000" RightMargin="8.0000" TopMargin="10.0000" BottomMargin="21.0000" Scale9Width="346" Scale9Height="122" ctype="ImageViewObjectData">
                            <Size X="310.0000" Y="100.0000" />
                            <Children>
                              <AbstractNodeData Name="Text_ChatContent" ActionTag="-1950594466" Tag="177" IconVisible="False" PositionPercentXEnabled="True" PercentWidthEnable="True" PercentHeightEnable="True" PercentWidthEnabled="True" PercentHeightEnabled="True" LeftMargin="22.8780" RightMargin="8.1220" TopMargin="5.0000" BottomMargin="5.0000" IsCustomSize="True" FontSize="24" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                                <Size X="279.0000" Y="90.0000" />
                                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                                <Position X="162.3780" Y="50.0000" />
                                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                                <CColor A="255" R="200" G="196" B="189" />
                                <PrePosition X="0.5238" Y="0.5000" />
                                <PreSize X="0.9000" Y="0.9000" />
                                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                                <OutlineColor A="255" R="255" G="0" B="0" />
                                <ShadowColor A="255" R="110" G="110" B="110" />
                              </AbstractNodeData>
                              <AbstractNodeData Name="Img_ChatEmoji" ActionTag="-1019472895" Tag="362" IconVisible="False" LeftMargin="30.5000" RightMargin="220.5000" TopMargin="8.5000" BottomMargin="28.5000" Scale9Width="46" Scale9Height="46" ctype="ImageViewObjectData">
                                <Size X="59.0000" Y="63.0000" />
                                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                                <Position X="60.0000" Y="60.0000" />
                                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                                <CColor A="255" R="255" G="255" B="255" />
                                <PrePosition X="0.1935" Y="0.6000" />
                                <PreSize X="0.1903" Y="0.6300" />
                                <FileData Type="Default" Path="Default/ImageFile.png" Plist="" />
                              </AbstractNodeData>
                            </Children>
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="296.0000" Y="71.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.6449" Y="0.5420" />
                            <PreSize X="0.6754" Y="0.7634" />
                            <FileData Type="MarkedSubImage" Path="image/Chat/text_bg.png" Plist="image/Chat/chat.plist" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint />
                        <Position Y="421.2948" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition Y="0.7628" />
                        <PreSize X="1.0030" Y="0.2372" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="0.0052" Y="1.3011" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0000" Y="0.0023" />
                    <PreSize X="0.9899" Y="0.9686" />
                    <SingleColor A="255" R="150" G="150" B="255" />
                    <FirstColor A="255" R="150" G="150" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="11.0000" Y="106.5067" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0189" Y="0.1500" />
                <PreSize X="0.7930" Y="0.8031" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Fix" Visible="False" ActionTag="-1163883249" Tag="147" IconVisible="False" LeftMargin="6.0000" RightMargin="110.8138" TopMargin="15.7471" BottomMargin="99.4075" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="466.1862" Y="594.8454" />
                <Children>
                  <AbstractNodeData Name="ListVw_fixMsg" ActionTag="1816102650" Tag="39" IconVisible="False" LeftMargin="5.0000" RightMargin="-3.8138" TopMargin="29.0084" BottomMargin="-1.7142" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ScrollDirectionType="0" ItemMargin="35" DirectionType="Vertical" ctype="ListViewObjectData">
                    <Size X="465.0000" Y="567.5512" />
                    <Children>
                      <AbstractNodeData Name="Btn_Fix1" ActionTag="2105384889" Tag="77" IconVisible="False" RightMargin="5.0000" BottomMargin="506.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix1" ActionTag="431351256" Tag="87" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.5000" BottomMargin="10.5000" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.5000" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="537.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.9463" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Fix2" ActionTag="-1401529085" ZOrder="1" Tag="78" IconVisible="False" RightMargin="5.0000" TopMargin="96.0000" BottomMargin="410.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix2" ActionTag="-12615296" Tag="89" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.6830" BottomMargin="10.3170" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.3170" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.4970" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="441.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.7771" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Fix3" ActionTag="-27250822" ZOrder="2" Tag="79" IconVisible="False" RightMargin="5.0000" TopMargin="192.0000" BottomMargin="314.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix3" ActionTag="962042722" Tag="90" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.5000" BottomMargin="10.5000" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.5000" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="345.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.6080" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Fix4" ActionTag="1311454008" ZOrder="3" Tag="80" IconVisible="False" RightMargin="5.0000" TopMargin="288.0000" BottomMargin="218.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix4" ActionTag="-124409503" Tag="91" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.5000" BottomMargin="10.5000" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.5000" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="249.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.4388" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Fix5" ActionTag="1837167931" ZOrder="4" Tag="81" IconVisible="False" RightMargin="5.0000" TopMargin="384.0000" BottomMargin="122.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix5" ActionTag="-798412345" Tag="92" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.5000" BottomMargin="10.5000" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.5000" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="153.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.2697" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Fix6" ActionTag="-562952315" ZOrder="5" Tag="82" IconVisible="False" RightMargin="5.0000" TopMargin="480.0000" BottomMargin="26.5512" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="435" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="460.0000" Y="61.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_Fix6" ActionTag="-1638677685" Tag="93" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="13.8000" RightMargin="-243.8000" TopMargin="10.5000" BottomMargin="10.5000" IsCustomSize="True" FontSize="26" LabelText="" VerticalAlignmentType="VT_Center" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="690.0000" Y="40.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="358.8000" Y="30.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="200" G="196" B="189" />
                            <PrePosition X="0.7800" Y="0.5000" />
                            <PreSize X="1.5000" Y="0.6557" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="230.0000" Y="57.0512" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4946" Y="0.1005" />
                        <PreSize X="0.9892" Y="0.1075" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/fix_bg.png" Plist="image/Chat/chat.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="5.0000" Y="-1.7142" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0107" Y="-0.0029" />
                    <PreSize X="0.9975" Y="0.9541" />
                    <SingleColor A="255" R="150" G="150" B="255" />
                    <FirstColor A="255" R="150" G="150" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="6.0000" Y="99.4075" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0103" Y="0.1400" />
                <PreSize X="0.7996" Y="0.8378" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Emoji" Visible="False" ActionTag="1071859261" Tag="148" IconVisible="False" LeftMargin="11.0000" RightMargin="109.0703" TopMargin="30.0065" BottomMargin="110.3393" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="462.9297" Y="569.6542" />
                <Children>
                  <AbstractNodeData Name="ScrollVw_emoji" ActionTag="-1745181001" Tag="683" IconVisible="False" LeftMargin="4.1407" RightMargin="13.7890" TopMargin="7.7738" BottomMargin="-2.1196" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" IsBounceEnabled="True" ScrollDirectionType="Vertical" ctype="ScrollViewObjectData">
                    <Size X="445.0000" Y="564.0000" />
                    <Children>
                      <AbstractNodeData Name="Btn_Emoji_1" ActionTag="-2070881212" Tag="50" IconVisible="False" LeftMargin="44.0000" RightMargin="300.0000" TopMargin="19.0000" BottomMargin="449.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="110.0000" Y="515.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.2311" Y="0.8583" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_angry.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Emoji_2" ActionTag="972060571" Tag="51" IconVisible="False" LeftMargin="284.0000" RightMargin="60.0000" TopMargin="19.0000" BottomMargin="449.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="350.0000" Y="515.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.7353" Y="0.8583" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_cool.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Emoji_3" ActionTag="1744483384" Tag="52" IconVisible="False" LeftMargin="44.0000" RightMargin="300.0000" TopMargin="204.0000" BottomMargin="264.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="110.0000" Y="330.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.2311" Y="0.5500" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_cry.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Emoji_4" ActionTag="-1573004150" Tag="53" IconVisible="False" LeftMargin="284.0000" RightMargin="60.0000" TopMargin="204.0000" BottomMargin="264.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="350.0000" Y="330.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.7353" Y="0.5500" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_happy.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Emoji_5" ActionTag="1290691398" Tag="55" IconVisible="False" LeftMargin="44.0000" RightMargin="300.0000" TopMargin="389.0000" BottomMargin="79.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="110.0000" Y="145.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.2311" Y="0.2417" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_suprise.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Btn_Emoji_6" ActionTag="1960928455" Tag="56" IconVisible="False" LeftMargin="284.0000" RightMargin="60.0000" TopMargin="389.0000" BottomMargin="79.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="102" Scale9Height="110" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="132.0000" Y="132.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="350.0000" Y="145.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.7353" Y="0.2417" />
                        <PreSize X="0.2773" Y="0.2200" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="MarkedSubImage" Path="image/Chat/emoji/emoticon_tears.png" Plist="image/Chat/emoji/emoji.plist" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="4.1407" Y="-2.1196" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0089" Y="-0.0037" />
                    <PreSize X="0.9613" Y="0.9901" />
                    <SingleColor A="255" R="255" G="150" B="100" />
                    <FirstColor A="255" R="255" G="150" B="100" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                    <InnerNodeSize Width="476" Height="600" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="11.0000" Y="110.3393" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0189" Y="0.1554" />
                <PreSize X="0.7940" Y="0.8023" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Input" ActionTag="1866468351" Tag="429" IconVisible="False" LeftMargin="9.0000" RightMargin="264.0000" TopMargin="634.7800" BottomMargin="13.2200" Scale9Width="310" Scale9Height="62" ctype="ImageViewObjectData">
                <Size X="310.0000" Y="62.0000" />
                <Children>
                  <AbstractNodeData Name="TextField_Enter" ActionTag="1088748491" Tag="359" RotationSkewX="-0.0245" RotationSkewY="-0.0246" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="14.5249" RightMargin="14.5248" TopMargin="10.1176" BottomMargin="10.1176" TouchEnable="True" FontSize="32" IsCustomSize="True" LabelText="" PlaceHolderText="请输入文字" MaxLengthText="10" ctype="TextFieldObjectData">
                    <Size X="280.9503" Y="41.7648" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="155.0000" Y="31.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.9063" Y="0.6736" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="164.0000" Y="44.2200" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2813" Y="0.0623" />
                <PreSize X="0.5317" Y="0.0873" />
                <FileData Type="MarkedSubImage" Path="image/Chat/input_bg.png" Plist="image/Chat/chat.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Chat_Fix" ActionTag="-1293407708" Tag="436" IconVisible="False" LeftMargin="477.0000" RightMargin="2.5203" TopMargin="259.0000" BottomMargin="320.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Enable="True" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="103.4797" Y="131.0000" />
                <AnchorPoint />
                <Position X="477.0000" Y="320.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8182" Y="0.4507" />
                <PreSize X="0.1775" Y="0.1845" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Chat_Emoji" ActionTag="1304654769" Tag="437" IconVisible="False" LeftMargin="477.0000" RightMargin="3.9657" TopMargin="92.9094" BottomMargin="486.0906" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Enable="True" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="102.0343" Y="131.0000" />
                <AnchorPoint />
                <Position X="477.0000" Y="486.0906" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8182" Y="0.6846" />
                <PreSize X="0.1750" Y="0.1845" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Panel_Chat_Record" ActionTag="-1509222576" Tag="2724" IconVisible="False" LeftMargin="477.0000" RightMargin="5.4111" TopMargin="424.0000" BottomMargin="155.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Enable="True" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="100.5889" Y="131.0000" />
                <AnchorPoint />
                <Position X="477.0000" Y="155.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8182" Y="0.2183" />
                <PreSize X="0.1725" Y="0.1845" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_ChoiceBg" ActionTag="-1657291780" Tag="833" IconVisible="False" LeftMargin="475.5000" RightMargin="4.5000" TopMargin="93.5000" BottomMargin="485.5000" Scale9Width="93" Scale9Height="131" ctype="ImageViewObjectData">
                <Size X="103.0000" Y="131.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="527.0000" Y="551.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9039" Y="0.7761" />
                <PreSize X="0.1767" Y="0.1845" />
                <FileData Type="MarkedSubImage" Path="image/Chat/img_choice.png" Plist="image/Chat/chat.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Chat" ActionTag="566477905" Tag="1835" IconVisible="False" LeftMargin="507.0000" RightMargin="38.0000" TopMargin="440.0000" BottomMargin="172.0000" Scale9Width="38" Scale9Height="98" ctype="ImageViewObjectData">
                <Size X="38.0000" Y="98.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="526.0000" Y="221.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9022" Y="0.3113" />
                <PreSize X="0.0652" Y="0.1380" />
                <FileData Type="MarkedSubImage" Path="image/Chat/btn_chat.png" Plist="image/Chat/chat.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Fix" ActionTag="30636178" Tag="830" IconVisible="False" LeftMargin="507.0000" RightMargin="38.0000" TopMargin="269.5000" BottomMargin="329.5000" Scale9Width="38" Scale9Height="111" ctype="ImageViewObjectData">
                <Size X="38.0000" Y="111.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="526.0000" Y="385.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9022" Y="0.5423" />
                <PreSize X="0.0652" Y="0.1563" />
                <FileData Type="MarkedSubImage" Path="image/Chat/btn_fix.png" Plist="image/Chat/chat.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Emoji" ActionTag="-1865651596" Tag="829" IconVisible="False" LeftMargin="506.0000" RightMargin="37.0000" TopMargin="104.2525" BottomMargin="492.7475" Scale9Width="40" Scale9Height="113" ctype="ImageViewObjectData">
                <Size X="40.0000" Y="113.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="526.0000" Y="549.2475" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9022" Y="0.7736" />
                <PreSize X="0.0686" Y="0.1592" />
                <FileData Type="MarkedSubImage" Path="image/Chat/btn_emoji.png" Plist="image/Chat/chat.plist" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="986.3680" Y="358.0560" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7706" Y="0.4973" />
            <PreSize X="0.4555" Y="0.9861" />
            <FileData Type="MarkedSubImage" Path="image/Chat/chat_bg.png" Plist="image/Chat/chat.plist" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>