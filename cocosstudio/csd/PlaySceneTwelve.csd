<GameFile>
  <PropertyGroup Name="PlaySceneTwelve" Type="Layer" ID="2722f513-fb27-467b-884c-ab983b55b359" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Layer" Tag="5" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="Img_Bg" ActionTag="-1638317472" Tag="1303" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-140.0000" RightMargin="-140.0000" TopMargin="-120.0000" BottomMargin="-120.0000" LeftEage="422" RightEage="422" TopEage="237" BottomEage="237" Scale9OriginX="422" Scale9OriginY="237" Scale9Width="436" Scale9Height="246" ctype="ImageViewObjectData">
            <Size X="1560.0000" Y="960.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.2188" Y="1.3333" />
            <FileData Type="Normal" Path="image/play/player12/play12bg1.jpg" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Spine" ActionTag="-1208359589" Tag="8389" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <AnchorPoint />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Top_Left" ActionTag="1607551619" Tag="2771" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" RightMargin="1280.0000" TopMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_NetworkBg" ActionTag="-1571761869" Tag="733" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" RightMargin="-180.0000" BottomMargin="-46.0000" LeftEage="73" RightEage="73" TopEage="15" BottomEage="15" Scale9OriginX="73" Scale9OriginY="15" Scale9Width="78" Scale9Height="16" ctype="ImageViewObjectData">
                <Size X="180.0000" Y="46.0000" />
                <Children>
                  <AbstractNodeData Name="Img_Network" ActionTag="-1431634142" Tag="734" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="14.1000" RightMargin="132.9000" TopMargin="10.0000" BottomMargin="10.0000" Scale9Width="33" Scale9Height="26" ctype="ImageViewObjectData">
                    <Size X="33.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="30.6000" Y="23.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.1700" Y="0.5000" />
                    <PreSize X="0.1833" Y="0.5652" />
                    <FileData Type="MarkedSubImage" Path="image/play/network_13.png" Plist="image/play/netandbattery.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_BatteryBg" ActionTag="1914160439" Tag="735" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="131.4000" RightMargin="12.6000" TopMargin="11.0000" BottomMargin="11.0000" Scale9Width="36" Scale9Height="24" ctype="ImageViewObjectData">
                    <Size X="36.0000" Y="24.0000" />
                    <Children>
                      <AbstractNodeData Name="LoadingBar_Battery" ActionTag="885805153" Tag="737" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="LoadingBarObjectData">
                        <Size X="36.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="18.0000" Y="12.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.0000" Y="1.0000" />
                        <ImageFileData Type="MarkedSubImage" Path="image/play/battery1.png" Plist="image/play/netandbattery.plist" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="149.4000" Y="23.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.8300" Y="0.5000" />
                    <PreSize X="0.2000" Y="0.5217" />
                    <FileData Type="MarkedSubImage" Path="image/play/battery_bg1.png" Plist="image/play/netandbattery.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_Network" ActionTag="-685370083" Tag="736" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="43.1240" RightMargin="56.8760" TopMargin="11.5000" BottomMargin="11.5000" FontSize="20" LabelText="1000ms" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="80.0000" Y="23.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="83.1240" Y="23.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="182" B="0" />
                    <PrePosition X="0.4618" Y="0.5000" />
                    <PreSize X="0.4444" Y="0.5000" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleY="1.0000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/play/time_bg1.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_RoundBg" ActionTag="-1775856643" Tag="624" IconVisible="True" LeftMargin="83.0469" RightMargin="-83.0469" TopMargin="-39.2313" BottomMargin="39.2313" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Label_Round" ActionTag="303143036" Tag="139" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-59.2526" RightMargin="-16.7474" TopMargin="-22.2130" BottomMargin="-2.7870" FontSize="20" LabelText="10/20局" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="76.0000" Y="25.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="-21.2526" Y="9.7130" />
                    <Scale ScaleX="1.0000" ScaleY="0.8524" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_Time" ActionTag="-1996980397" Tag="142" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-28.5000" RightMargin="-28.5000" TopMargin="-12.5000" BottomMargin="-12.5000" FontSize="20" LabelText="12:00" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="57.0000" Y="25.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="83.0469" Y="39.2313" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Trusteeship" ActionTag="484366635" Tag="3285" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="16.6598" RightMargin="-82.6598" TopMargin="-266.6362" BottomMargin="178.6362" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="36" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="66.0000" Y="88.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="49.6598" Y="222.6362" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_trusteeship.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Top_Center" ActionTag="1532362774" Tag="2775" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" RightMargin="1280.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_SetBg" ActionTag="1150895753" Tag="623" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Image_122" ActionTag="1959591173" Tag="1302" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-90.5001" RightMargin="-130.4999" TopMargin="-19.0000" BottomMargin="-19.0000" LeftEage="72" RightEage="72" TopEage="12" BottomEage="12" Scale9OriginX="72" Scale9OriginY="12" Scale9Width="77" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="221.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="19.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/player12/roomInfoBg12.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_RoomNumber" ActionTag="-229489714" Tag="145" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="21.8364" RightMargin="-107.8364" TopMargin="13.8423" BottomMargin="-40.8423" FontSize="22" LabelText="888888" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="86.0000" Y="27.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="21.8364" Y="-27.3423" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Logo" ActionTag="335893564" Tag="325" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" RightMargin="-160.0000" TopMargin="-32.5000" BottomMargin="-32.5000" LeftEage="41" RightEage="41" TopEage="18" BottomEage="18" Scale9OriginX="41" Scale9OriginY="18" Scale9Width="44" Scale9Height="19" ctype="ImageViewObjectData">
                <Size X="160.0000" Y="65.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="80.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/common/small_logo.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Top_Right" ActionTag="-878718010" Tag="2772" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" RightMargin="1280.0000" BottomMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Btn_Info" ActionTag="-1937653221" Tag="1011" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="9.2587" RightMargin="-69.2587" TopMargin="104.0553" BottomMargin="-165.0553" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="30" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="60.0000" Y="61.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="39.2587" Y="-134.5553" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/common/room_tip.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_setting" ActionTag="2139061361" Tag="58" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="3.6917" RightMargin="-78.6917" TopMargin="9.1688" BottomMargin="-79.1688" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="39" Scale9Height="48" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="41.1917" Y="-44.1688" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_setting.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position Y="720.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition Y="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Center_Center" ActionTag="1757015523" Tag="2774" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_BgWaitingTip" ActionTag="339301504" Tag="395" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-361.0000" RightMargin="19.0000" TopMargin="-27.0300" BottomMargin="-17.9700" Scale9Enable="True" LeftEage="102" RightEage="102" TopEage="5" BottomEage="5" Scale9OriginX="102" Scale9OriginY="5" Scale9Width="107" Scale9Height="35" ctype="ImageViewObjectData">
                <Size X="342.0000" Y="45.0000" />
                <Children>
                  <AbstractNodeData Name="Label_WatingTip" ActionTag="-1174168511" Tag="378" IconVisible="False" LeftMargin="-22.0000" RightMargin="-22.0000" TopMargin="7.5000" BottomMargin="8.5000" FontSize="24" LabelText="本局已经开始，请等待下局开始......" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="386.0000" Y="29.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="171.0000" Y="23.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="165" B="0" />
                    <PrePosition X="0.5000" Y="0.5111" />
                    <PreSize X="1.1287" Y="0.6444" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-190.0000" Y="4.5300" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/common/waiting_tip_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Label_PlayTimeCD" ActionTag="425601641" Tag="92" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-170.0000" RightMargin="170.0000" FontSize="24" LabelText="" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="0.0000" Y="0.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-170.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="165" B="0" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                <OutlineColor A="255" R="26" G="26" B="26" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_Score" ActionTag="1741492927" VisibleForFrame="False" Tag="4082" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-62.0000" RightMargin="-62.0000" TopMargin="-13.5000" BottomMargin="-13.5000" FontSize="24" LabelText="Text Label" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="124.0000" Y="27.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="93" G="147" B="197" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_PlayerInfo" ActionTag="-564814813" Tag="101" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_playerInfo_1" ActionTag="-2147180752" Tag="147" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1178.5812" RightMargin="-1178.5812" TopMargin="-69.9998" BottomMargin="69.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-2079120751" Tag="396" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-1281497612" Tag="148" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="-978854223" Tag="403" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="272548655" Tag="278" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="-708430942" Tag="151" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1331798555" Tag="150" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1194977162" Tag="153" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="2095926601" Tag="102" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="407521844" Tag="159" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="-623065152" Tag="329" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-5.5000" BottomMargin="-17.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-6.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="1576518522" Tag="237" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="544338399" Tag="483" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="-5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="105" G="173" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1178.5812" Y="69.9998" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_2" ActionTag="-2095991133" Tag="104" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="822.3162" RightMargin="-822.3162" TopMargin="-625.4933" BottomMargin="625.4933" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-1514817213" Tag="397" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="395518871" Tag="404" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="-1780097549" Tag="405" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="852522241" Tag="279" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="1797901143" Tag="407" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1471377261" Tag="408" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-534020362" Tag="109" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1929339138" Tag="409" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-1294567285" Tag="160" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="1870094060" Tag="330" IconVisible="False" LeftMargin="-144.0000" RightMargin="64.0000" TopMargin="-5.5000" BottomMargin="-17.5000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="1.0000" ScaleY="0.5000" />
                        <Position X="-64.0000" Y="-6.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="-287642997" Tag="238" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-390275753" Tag="484" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="822.3162" Y="625.4933" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_3" ActionTag="36546705" Tag="112" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="658.0013" RightMargin="-658.0013" TopMargin="-625.4933" BottomMargin="625.4933" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-463600804" Tag="398" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-743618126" Tag="410" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="648151081" Tag="411" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="588828745" Tag="280" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="1873190318" Tag="413" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1033505245" Tag="414" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-1136993236" Tag="117" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1049705605" Tag="415" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="446885783" Tag="161" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="671339030" Tag="331" IconVisible="False" LeftMargin="-144.0000" RightMargin="64.0000" TopMargin="-5.5000" BottomMargin="-17.5000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="1.0000" ScaleY="0.5000" />
                        <Position X="-64.0000" Y="-6.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="1131248724" Tag="239" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-1486357351" Tag="485" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="658.0013" Y="625.4933" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_4" ActionTag="-1129560041" Tag="287" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="492.0025" RightMargin="-492.0025" TopMargin="-625.4933" BottomMargin="625.4933" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="635142183" Tag="288" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-430240461" Tag="289" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="1634326315" Tag="290" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-1300077664" Tag="291" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="684958071" Tag="292" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="480102136" Tag="293" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-376059006" Tag="294" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="246719448" Tag="295" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-1666762633" Tag="296" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="1925184033" Tag="297" IconVisible="False" LeftMargin="-144.0000" RightMargin="64.0000" TopMargin="-5.5000" BottomMargin="-17.5000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="1.0000" ScaleY="0.5000" />
                        <Position X="-64.0000" Y="-6.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="-1829018235" Tag="298" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="943976042" Tag="299" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="492.0025" Y="625.4933" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_5" ActionTag="2068382553" Tag="313" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="327.0020" RightMargin="-327.0020" TopMargin="-625.4933" BottomMargin="625.4933" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-2027980178" Tag="314" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-1602594915" Tag="315" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="-2098630382" Tag="316" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="1041297993" Tag="317" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="1182922941" Tag="318" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="382698021" Tag="319" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-120992367" Tag="320" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="2046660333" Tag="321" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="541290995" Tag="322" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="2060998584" Tag="323" IconVisible="False" LeftMargin="-144.0000" RightMargin="64.0000" TopMargin="-5.5000" BottomMargin="-17.5000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="1.0000" ScaleY="0.5000" />
                        <Position X="-64.0000" Y="-6.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="-107360632" Tag="324" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-2138756788" Tag="325" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="327.0020" Y="625.4933" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_6" ActionTag="1447082605" Tag="120" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="169.9999" RightMargin="-169.9999" TopMargin="-625.4933" BottomMargin="625.4933" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="307941435" Tag="399" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-2098957641" Tag="416" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="-593827721" Tag="417" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-496190687" Tag="281" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="326768013" Tag="419" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-351697795" Tag="420" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="1019551519" Tag="125" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1100260836" Tag="421" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-2024174746" Tag="162" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="1633875679" Tag="332" IconVisible="False" LeftMargin="-157.6319" RightMargin="77.6319" TopMargin="-14.0274" BottomMargin="-8.9726" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="1.0000" ScaleY="0.5000" />
                        <Position X="-77.6319" Y="2.5274" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="2042806418" Tag="240" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1309758234" Tag="486" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="169.9999" Y="625.4933" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_7" ActionTag="91151184" Tag="128" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="169.9999" RightMargin="-169.9999" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-2103746687" Tag="400" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="56232834" Tag="422" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="1942562635" Tag="423" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="304099678" Tag="282" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="1104304545" Tag="425" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-2058991430" Tag="426" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-386593533" Tag="133" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="511842356" Tag="427" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="1869207916" Tag="163" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="-1682181367" Tag="333" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="94915205" Tag="241" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-337444339" Tag="487" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="169.9999" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_8" ActionTag="177839079" Tag="136" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="327.0020" RightMargin="-327.0020" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="1204918784" Tag="401" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="1369673006" Tag="428" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="160998785" Tag="429" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-1032456386" Tag="283" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="-451278137" Tag="431" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="654745457" Tag="432" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-1476607166" Tag="141" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1511634832" Tag="433" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-1729546635" Tag="164" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="-685483666" Tag="334" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="1756183654" Tag="242" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-680450526" Tag="488" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="327.0020" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_9" ActionTag="305000570" Tag="635" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="492.0025" RightMargin="-492.0025" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-748847083" Tag="636" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="861064178" Tag="637" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="1441663117" Tag="638" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-1015451371" Tag="639" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="-165133571" Tag="640" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1476456836" Tag="641" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-667104692" Tag="642" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1059293450" Tag="643" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-1260751235" Tag="644" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="363849290" Tag="645" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="-1821472947" Tag="646" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-1562828165" Tag="647" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="492.0025" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_10" ActionTag="1678783757" Tag="653" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="648.0013" RightMargin="-648.0013" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-2057766062" Tag="654" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-665291032" Tag="655" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="1447980070" Tag="656" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-605159622" Tag="657" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="-531668553" Tag="658" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="-2063314510" Tag="659" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-2143003145" Tag="660" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="-1333938990" Tag="661" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-1724739109" Tag="662" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="-1003297593" Tag="663" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="2133074588" Tag="664" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1830008692" Tag="665" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="648.0013" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_11" ActionTag="913424329" Tag="2295" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="812.3162" RightMargin="-812.3162" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="832550961" Tag="2296" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-1946079133" Tag="2297" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="-474154799" Tag="2298" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-642971887" Tag="2299" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="906026678" Tag="2300" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="1785970495" Tag="2301" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="1684150551" Tag="2302" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="1250632320" Tag="2303" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="-126607973" Tag="2304" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="-1707316012" Tag="2305" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="-1626691855" Tag="2306" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1792873526" Tag="2307" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="812.3162" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_12" ActionTag="-1634214903" Tag="2308" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="972.0015" RightMargin="-972.0015" TopMargin="-59.9998" BottomMargin="59.9998" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="head_bg" ActionTag="-1427109764" Tag="2309" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-517072345" Tag="2310" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <Children>
                          <AbstractNodeData Name="Spr_HeadFrame" ActionTag="673361183" Tag="2311" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                            <Size X="106.0000" Y="106.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.1042" Y="1.1042" />
                            <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="Spr_Head" ActionTag="-78584535" Tag="2312" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="25.0000" BottomMargin="25.0000" ctype="SpriteObjectData">
                            <Size X="46.0000" Y="46.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.4792" Y="0.4792" />
                            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                            <BlendFunc Src="770" Dst="771" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <SingleColor A="255" R="150" G="200" B="255" />
                        <FirstColor A="255" R="150" G="200" B="255" />
                        <EndColor A="255" R="255" G="255" B="255" />
                        <ColorVector ScaleY="1.0000" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_NickBg" ActionTag="2033177146" Tag="2313" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="18.0000" BottomMargin="-46.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                        <Size X="94.0000" Y="28.0000" />
                        <Children>
                          <AbstractNodeData Name="Label_Nick" ActionTag="1872514515" Tag="2314" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="5.5000" RightMargin="5.5000" TopMargin="2.5000" BottomMargin="2.5000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="83.0000" Y="23.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8830" Y="0.8214" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="255" G="0" B="0" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-32.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_bankerSign" ActionTag="-1575813742" Tag="2315" IconVisible="False" LeftMargin="6.5000" RightMargin="-53.5000" TopMargin="-52.5000" BottomMargin="7.5000" ctype="SpriteObjectData">
                        <Size X="47.0000" Y="45.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="30.0000" Y="30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Score" ActionTag="1738899422" Tag="2316" IconVisible="False" LeftMargin="-37.5000" RightMargin="-37.5000" TopMargin="56.0000" BottomMargin="-92.0000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="75.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-74.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_offline" ActionTag="971585453" Tag="2317" IconVisible="False" LeftMargin="-21.5000" RightMargin="-21.5000" TopMargin="40.5000" BottomMargin="-63.5000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="43.0000" Y="23.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-52.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="191" G="191" B="191" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_Wait" ActionTag="608802229" Tag="2318" IconVisible="False" LeftMargin="70.0000" RightMargin="-150.0000" TopMargin="-3.5000" BottomMargin="-19.5000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="80.0000" Y="23.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="70.0000" Y="-8.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_RobZhuang" ActionTag="1814942993" Tag="2319" IconVisible="False" LeftMargin="-67.5000" RightMargin="-67.5000" TopMargin="-60.0000" BottomMargin="-96.0000" ctype="SpriteObjectData">
                        <Size X="135.0000" Y="156.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="-18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/rob_zhuang.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1857701874" Tag="2320" IconVisible="False" LeftMargin="-63.0000" RightMargin="-63.0000" TopMargin="-25.0000" BottomMargin="-25.0000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="126.0000" Y="50.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="249" G="207" B="65" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="26" G="26" B="26" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="972.0015" Y="59.9998" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_play" ActionTag="1862310019" Tag="159" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="pCard1" ActionTag="1358611441" Tag="281" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="549.4069" RightMargin="-549.4069" TopMargin="-52.3113" BottomMargin="52.3113" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="1605723707" Tag="100" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-170.0005" RightMargin="90.0005" TopMargin="-50.0000" BottomMargin="-50.0000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="80.0000" Y="100.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-130.0005" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1130501432" Tag="101" IconVisible="False" LeftMargin="-92.0004" RightMargin="12.0004" TopMargin="-50.0001" BottomMargin="-49.9999" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="80.0000" Y="100.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-52.0004" Y="0.0001" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1409795471" Tag="102" IconVisible="False" LeftMargin="-10.0001" RightMargin="-69.9999" TopMargin="-49.9998" BottomMargin="-50.0002" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="80.0000" Y="100.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="29.9999" Y="-0.0002" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="786856253" Tag="103" IconVisible="False" LeftMargin="68.0001" RightMargin="-148.0001" TopMargin="-49.9998" BottomMargin="-50.0002" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="80.0000" Y="100.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="108.0001" Y="-0.0002" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="265105391" Tag="104" IconVisible="False" LeftMargin="146.0002" RightMargin="-226.0002" TopMargin="-49.9998" BottomMargin="-50.0002" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="80.0000" Y="100.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="186.0002" Y="-0.0002" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-1602541831" Tag="341" IconVisible="False" LeftMargin="-144.1958" RightMargin="-159.8042" TopMargin="-148.0345" BottomMargin="-138.9655" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="7.8042" Y="4.5345" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="961199490" Tag="699" IconVisible="False" LeftMargin="136.6972" RightMargin="-206.6972" TopMargin="-0.0925" BottomMargin="-69.9075" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="171.6972" Y="-34.9075" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="-734411218" Tag="163" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-125.5000" BottomMargin="90.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="-1845163363" Tag="161" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="108.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="549.4069" Y="52.3113" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard2" ActionTag="-2035422733" Tag="282" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="180.1902" RightMargin="-180.1902" TopMargin="-114.7555" BottomMargin="114.7555" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-1419871714" Tag="86" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-142447069" Tag="87" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-2119618406" Tag="88" IconVisible="False" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="1868195015" Tag="89" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-526944076" Tag="90" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-280987009" Tag="342" IconVisible="False" LeftMargin="-155.9998" RightMargin="-148.0002" TopMargin="-133.5000" BottomMargin="-153.5000" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-3.9998" Y="-10.0000" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/wuxiaoniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-925634523" Tag="700" IconVisible="False" LeftMargin="44.9999" RightMargin="-114.9999" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="79.9999" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="17723345" Tag="164" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="1909991873" Tag="165" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="180.1902" Y="114.7555" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard3" ActionTag="-377308156" Tag="283" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="32.5139" RightMargin="-32.5139" TopMargin="-124.2647" BottomMargin="124.2647" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-1718518903" Tag="79" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-980967287" Tag="80" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="579587136" Tag="81" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="534142713" Tag="82" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-1906674893" Tag="83" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-202330297" Tag="343" IconVisible="False" LeftMargin="-165.5090" RightMargin="-138.4910" TopMargin="-133.5004" BottomMargin="-153.4996" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-13.5090" Y="-9.9996" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-1094677666" Tag="701" IconVisible="False" LeftMargin="35.4908" RightMargin="-105.4908" TopMargin="-10.9999" BottomMargin="-59.0001" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="70.4908" Y="-24.0001" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="-674780098" Tag="166" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="-722770046" Tag="167" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="32.5139" Y="124.2647" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard4" ActionTag="-530326075" Tag="300" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-135.3815" RightMargin="135.3815" TopMargin="-122.6572" BottomMargin="122.6572" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="751426698" Tag="301" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="537440643" Tag="302" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-2142746723" Tag="303" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="538607423" Tag="304" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-1286449451" Tag="305" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="1356985797" Tag="306" IconVisible="False" LeftMargin="-163.9015" RightMargin="-140.0985" TopMargin="-133.5001" BottomMargin="-153.4999" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-11.9015" Y="-9.9999" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-931649983" Tag="307" IconVisible="False" LeftMargin="37.0982" RightMargin="-107.0982" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="72.0982" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="1699407529" Tag="308" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="-1242675772" Tag="309" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-135.3815" Y="122.6572" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard5" ActionTag="-411971728" Tag="328" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-308.5507" RightMargin="308.5507" TopMargin="-123.3513" BottomMargin="123.3513" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="210970227" Tag="329" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1270974244" Tag="330" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="1587752267" Tag="331" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-2018387286" Tag="332" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="54847529" Tag="333" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-1326578467" Tag="334" IconVisible="False" LeftMargin="-164.5956" RightMargin="-139.4044" TopMargin="-133.5000" BottomMargin="-153.5000" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-12.5956" Y="-10.0000" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-1693396991" Tag="335" IconVisible="False" LeftMargin="36.4041" RightMargin="-106.4041" TopMargin="-11.0001" BottomMargin="-58.9999" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="71.4041" Y="-23.9999" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="2063426970" Tag="336" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="610092935" Tag="337" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-308.5507" Y="123.3513" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard6" ActionTag="242161140" Tag="284" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-471.2084" RightMargin="471.2084" TopMargin="-119.9568" BottomMargin="119.9568" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="281200886" Tag="72" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="1965169167" Tag="73" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1858087972" Tag="74" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-375085538" Tag="75" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-1733811686" Tag="76" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-1971591973" Tag="344" IconVisible="False" LeftMargin="-161.2010" RightMargin="-142.7990" TopMargin="-133.5001" BottomMargin="-153.4999" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-9.2010" Y="-9.9999" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-1704771907" Tag="702" IconVisible="False" LeftMargin="39.7986" RightMargin="-109.7986" TopMargin="-11.0001" BottomMargin="-58.9999" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="74.7986" Y="-23.9999" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="-1298424822" Tag="168" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="438177392" Tag="169" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-471.2084" Y="119.9568" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard7" ActionTag="897666246" Tag="285" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-465.6765" RightMargin="465.6765" TopMargin="149.9280" BottomMargin="-149.9280" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-1496521407" Tag="64" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1942411073" Tag="65" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="177699193" Tag="66" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-936764182" Tag="67" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-1726438000" Tag="68" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-2018969067" Tag="345" IconVisible="False" LeftMargin="-172.7168" RightMargin="-131.2832" TopMargin="-133.5002" BottomMargin="-153.4998" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-20.7168" Y="-9.9998" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="1819894423" Tag="703" IconVisible="False" LeftMargin="24.9999" RightMargin="-94.9999" TopMargin="-11.0001" BottomMargin="-58.9999" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="59.9999" Y="-23.9999" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="1571983544" Tag="170" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="201964333" Tag="171" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-465.6765" Y="-149.9280" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard8" ActionTag="-620441400" Tag="286" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-309.3441" RightMargin="309.3441" TopMargin="154.0181" BottomMargin="-154.0181" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="1172209137" Tag="93" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1084706604" Tag="94" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1645177011" Tag="95" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-817692925" Tag="96" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="2068399848" Tag="97" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-1388383355" Tag="346" IconVisible="False" LeftMargin="-168.6267" RightMargin="-135.3733" TopMargin="-133.4999" BottomMargin="-153.5001" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-16.6267" Y="-10.0001" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="815891688" Tag="704" IconVisible="False" LeftMargin="25.0002" RightMargin="-95.0002" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="60.0002" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="1107164487" Tag="172" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="13648181" Tag="173" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-309.3441" Y="-154.0181" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard9" ActionTag="-357572213" Tag="625" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="-150.9173" RightMargin="150.9173" TopMargin="155.8057" BottomMargin="-155.8057" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-76911055" Tag="626" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="14685947" Tag="627" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-400155131" Tag="628" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-1655300208" Tag="629" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-954187849" Tag="630" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="358067530" Tag="631" IconVisible="False" LeftMargin="-166.8391" RightMargin="-137.1609" TopMargin="-133.5005" BottomMargin="-153.4995" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-14.8391" Y="-9.9995" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-67393746" Tag="632" IconVisible="False" LeftMargin="24.9999" RightMargin="-94.9999" TopMargin="-10.9999" BottomMargin="-59.0001" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="59.9999" Y="-24.0001" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="968416827" Tag="633" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="1997755289" Tag="634" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-150.9173" Y="-155.8057" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard10" ActionTag="-1650995708" Tag="666" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="18.8206" RightMargin="-18.8206" TopMargin="155.1305" BottomMargin="-155.1305" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="127394346" Tag="667" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-48870113" Tag="668" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="1241435493" Tag="669" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="627912268" Tag="670" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="1723881528" Tag="671" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-323168308" Tag="672" IconVisible="False" LeftMargin="-167.5143" RightMargin="-136.4857" TopMargin="-133.5007" BottomMargin="-153.4993" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.5143" Y="-9.9993" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="809853214" Tag="673" IconVisible="False" LeftMargin="24.9999" RightMargin="-94.9999" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="59.9999" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="-1845559810" Tag="674" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="248895593" Tag="675" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="18.8206" Y="-155.1305" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard11" ActionTag="-310496597" Tag="2321" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="178.1945" RightMargin="-178.1945" TopMargin="156.6448" BottomMargin="-156.6448" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="1593094451" Tag="2322" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="202584798" Tag="2323" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="1722044876" Tag="2324" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="-1739157603" Tag="2325" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-2052643289" Tag="2326" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="1525634693" Tag="2327" IconVisible="False" LeftMargin="-166.0000" RightMargin="-138.0000" TopMargin="-133.5005" BottomMargin="-153.4995" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-14.0000" Y="-9.9995" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="480803697" Tag="2328" IconVisible="False" LeftMargin="24.9999" RightMargin="-94.9999" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="59.9999" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="1423760345" Tag="2329" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="902066746" Tag="2330" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="178.1945" Y="-156.6448" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard12" ActionTag="382041759" Tag="2331" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="333.8935" RightMargin="-333.8935" TopMargin="156.4607" BottomMargin="-156.4607" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="1325557900" Tag="2332" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-219121278" Tag="2333" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-58.0000" RightMargin="-8.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1712400942" Tag="2334" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-33.0000" RightMargin="-33.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad4" ActionTag="1362293030" Tag="2335" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-8.0000" RightMargin="-58.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad5" ActionTag="-1652895892" Tag="2336" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuType" ActionTag="-953826041" Tag="2337" IconVisible="False" LeftMargin="-166.1841" RightMargin="-137.8159" TopMargin="-133.5006" BottomMargin="-153.4994" Scale9Width="304" Scale9Height="287" ctype="ImageViewObjectData">
                        <Size X="304.0000" Y="287.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-14.1841" Y="-9.9994" />
                        <Scale ScaleX="0.4200" ScaleY="0.4200" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/niuniu.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgNiuRate" ActionTag="-2040122257" Tag="2338" IconVisible="False" LeftMargin="24.9999" RightMargin="-94.9999" TopMargin="-11.0000" BottomMargin="-59.0000" Scale9Width="70" Scale9Height="70" ctype="ImageViewObjectData">
                        <Size X="70.0000" Y="70.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="59.9999" Y="-24.0000" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play/niu/b3.png" Plist="image/play/niu/niu.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Score" ActionTag="-566173808" Tag="2339" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-73.5000" BottomMargin="38.5000" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="lblScore" ActionTag="824096016" Tag="2340" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="21.0000" RightMargin="21.0000" TopMargin="-3.0000" BottomMargin="-3.0000" FontSize="32" LabelText="+10" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="64.0000" Y="41.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.6038" Y="1.1714" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="56.0000" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="333.8935" Y="-156.4607" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_chatBg" Visible="False" ActionTag="86755513" Tag="100" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_PlayerChatBg_1" ActionTag="372981031" Tag="286" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1167.4359" RightMargin="-1167.4359" TopMargin="-281.9139" BottomMargin="281.9139" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-781172571" Tag="175" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="145784063" Tag="314" IconVisible="False" LeftMargin="-121.5000" RightMargin="-133.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1167.4359" Y="281.9139" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_2" ActionTag="1314503765" Tag="287" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="842.3579" RightMargin="-842.3579" TopMargin="-433.9396" BottomMargin="433.9396" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-1468671129" Tag="176" RotationSkewY="-180.0000" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="854709096" Tag="315" IconVisible="False" LeftMargin="-133.5000" RightMargin="-121.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="842.3579" Y="433.9396" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_3" ActionTag="1143618584" Tag="289" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="680.1399" RightMargin="-680.1399" TopMargin="-433.9396" BottomMargin="433.9396" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="605370910" Tag="178" RotationSkewY="-180.0000" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="-223602675" Tag="316" IconVisible="False" LeftMargin="-133.5000" RightMargin="-121.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="680.1399" Y="433.9396" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_4" ActionTag="-2028363259" Tag="831" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="524.8894" RightMargin="-524.8894" TopMargin="-433.9396" BottomMargin="433.9396" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="1004789073" Tag="832" RotationSkewY="-180.0000" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="1416399112" Tag="833" IconVisible="False" LeftMargin="-133.5000" RightMargin="-121.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="524.8894" Y="433.9396" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_5" ActionTag="-1192175682" Tag="836" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="358.0971" RightMargin="-358.0971" TopMargin="-433.9396" BottomMargin="433.9396" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-779782068" Tag="837" RotationSkewY="-180.0000" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="162956698" Tag="838" IconVisible="False" LeftMargin="-133.5000" RightMargin="-121.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="358.0971" Y="433.9396" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_6" ActionTag="923552737" Tag="290" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="188.8026" RightMargin="-188.8026" TopMargin="-433.9396" BottomMargin="433.9396" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="803629715" Tag="179" RotationSkewY="-180.0000" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="1622453208" Tag="317" IconVisible="False" LeftMargin="-121.5000" RightMargin="-133.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="188.8026" Y="433.9396" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_7" ActionTag="187079672" Tag="291" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="189.7133" RightMargin="-189.7133" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-1434244058" Tag="180" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="875746622" Tag="318" IconVisible="False" LeftMargin="-121.5000" RightMargin="-133.5000" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0000" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="189.7133" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_8" ActionTag="1372580138" Tag="292" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="347.5373" RightMargin="-347.5373" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-819757309" Tag="181" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="-965728753" Tag="319" IconVisible="False" LeftMargin="-121.4997" RightMargin="-133.5003" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0003" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="347.5373" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_9" ActionTag="-892570071" Tag="841" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="514.4451" RightMargin="-514.4451" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-1440770674" Tag="842" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="-1598935022" Tag="843" IconVisible="False" LeftMargin="-121.4997" RightMargin="-133.5003" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0003" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="514.4451" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_10" ActionTag="1964454588" Tag="846" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="683.8805" RightMargin="-683.8805" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="2095016678" Tag="847" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="333309803" Tag="848" IconVisible="False" LeftMargin="-121.4997" RightMargin="-133.5003" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0003" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="683.8805" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_11" ActionTag="1286359434" Tag="2341" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="833.1331" RightMargin="-833.1331" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-1663832737" Tag="2342" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="1179125665" Tag="2343" IconVisible="False" LeftMargin="-121.4997" RightMargin="-133.5003" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0003" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="833.1331" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_12" ActionTag="-1749551759" Tag="2344" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="983.0337" RightMargin="-983.0337" TopMargin="-253.6859" BottomMargin="253.6859" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="-1476953764" Tag="2345" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
                        <Size X="283.1681" Y="132.0594" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/play/chat_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Contend" ActionTag="-943989543" Tag="2346" IconVisible="False" LeftMargin="-121.4997" RightMargin="-133.5003" TopMargin="-59.5000" BottomMargin="-63.5000" IsCustomSize="True" FontSize="36" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="255.0000" Y="123.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.0003" Y="-2.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="983.0337" Y="253.6859" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_1" ActionTag="1689626635" Tag="186" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1177.2882" RightMargin="-1177.2882" TopMargin="-72.7613" BottomMargin="72.7613" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="-1373353817" VisibleForFrame="False" Tag="230" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1177.2882" Y="72.7613" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_2" ActionTag="1922246611" Tag="187" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="855.0557" RightMargin="-855.0557" TopMargin="-622.0275" BottomMargin="622.0275" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="398642099" VisibleForFrame="False" Tag="231" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="855.0557" Y="622.0275" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_3" ActionTag="-415681489" Tag="188" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="702.2883" RightMargin="-702.2883" TopMargin="-625.6589" BottomMargin="625.6589" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="-1438758044" VisibleForFrame="False" Tag="232" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="702.2883" Y="625.6589" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_4" ActionTag="1508810111" Tag="834" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="541.1754" RightMargin="-541.1754" TopMargin="-625.1665" BottomMargin="625.1665" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="1908443183" VisibleForFrame="False" Tag="835" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="541.1754" Y="625.1665" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_5" ActionTag="39105468" Tag="839" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="359.5211" RightMargin="-359.5211" TopMargin="-623.8646" BottomMargin="623.8646" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="2053660194" VisibleForFrame="False" Tag="840" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="359.5211" Y="623.8646" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_6" ActionTag="-1616968467" Tag="189" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="200.7022" RightMargin="-200.7022" TopMargin="-620.4698" BottomMargin="620.4698" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="477239488" VisibleForFrame="False" Tag="233" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="200.7022" Y="620.4698" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_7" ActionTag="-1000075740" Tag="190" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="201.1428" RightMargin="-201.1428" TopMargin="-72.2106" BottomMargin="72.2106" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="12008971" VisibleForFrame="False" Tag="234" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="201.1428" Y="72.2106" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_8" ActionTag="69323219" Tag="192" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="356.4752" RightMargin="-356.4752" TopMargin="-63.3311" BottomMargin="63.3311" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="1514271695" VisibleForFrame="False" Tag="235" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="356.4752" Y="63.3311" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_9" ActionTag="-1109952226" Tag="844" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="525.3876" RightMargin="-525.3876" TopMargin="-65.5193" BottomMargin="65.5193" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="-356187061" VisibleForFrame="False" Tag="845" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="525.3876" Y="65.5193" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_10" ActionTag="-2073172106" Tag="849" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="690.0350" RightMargin="-690.0350" TopMargin="-66.9827" BottomMargin="66.9827" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="-206277201" VisibleForFrame="False" Tag="850" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="690.0350" Y="66.9827" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_11" ActionTag="-884906406" Tag="2347" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="844.3162" RightMargin="-844.3162" TopMargin="-65.4698" BottomMargin="65.4698" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="-434398174" VisibleForFrame="False" Tag="2348" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="844.3162" Y="65.4698" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_12" ActionTag="1425276136" Tag="2349" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="993.5024" RightMargin="-993.5024" TopMargin="-62.2592" BottomMargin="62.2592" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_Emoji" ActionTag="1409252075" VisibleForFrame="False" Tag="2350" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
                        <Size X="46.0000" Y="46.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                        <BlendFunc Src="770" Dst="771" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="993.5024" Y="62.2592" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_Yuyin_Dlg" ActionTag="1764699135" Tag="99" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Image_1" ActionTag="-428410054" Tag="233" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="1123.6205" RightMargin="-1155.6205" TopMargin="-180.1716" BottomMargin="144.1716" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1139.6205" Y="162.1716" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_2" ActionTag="-250808957" Tag="234" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="780.9977" RightMargin="-812.9977" TopMargin="-565.9999" BottomMargin="529.9999" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="796.9977" Y="547.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_3" ActionTag="942178920" Tag="239" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="613.9973" RightMargin="-645.9973" TopMargin="-565.9999" BottomMargin="529.9999" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="629.9973" Y="547.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_4" ActionTag="-807207636" Tag="310" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="469.3468" RightMargin="-501.3468" TopMargin="-565.9999" BottomMargin="529.9999" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="485.3468" Y="547.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_5" ActionTag="1045842014" Tag="338" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="294.5396" RightMargin="-326.5396" TopMargin="-565.9999" BottomMargin="529.9999" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="310.5396" Y="547.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_6" ActionTag="-407487166" Tag="236" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="136.4085" RightMargin="-168.4085" TopMargin="-565.9999" BottomMargin="529.9999" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="152.4085" Y="547.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_7" ActionTag="-809915303" Tag="237" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="146.9865" RightMargin="-178.9865" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="162.9865" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_8" ActionTag="1408973810" Tag="238" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="305.5996" RightMargin="-337.5996" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="321.5996" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_9" ActionTag="-1170105336" Tag="652" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="463.1386" RightMargin="-495.1386" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="479.1386" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_10" ActionTag="1357628475" Tag="676" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="623.0912" RightMargin="-655.0912" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="639.0912" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_11" ActionTag="-948202552" Tag="2353" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="778.0149" RightMargin="-810.0149" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="794.0149" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_12" ActionTag="806488379" Tag="2354" RotationSkewX="90.0000" RotationSkewY="90.0000" IconVisible="False" LeftMargin="932.9407" RightMargin="-964.9407" TopMargin="-153.8114" BottomMargin="117.8114" LeftEage="10" RightEage="10" TopEage="11" BottomEage="11" Scale9OriginX="10" Scale9OriginY="11" Scale9Width="12" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="948.9407" Y="135.8114" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_pledgeSign" ActionTag="-357394960" Tag="497" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Img_pledgeSign_1" ActionTag="-897386010" Tag="544" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="1140.5256" RightMargin="-1240.5256" TopMargin="-213.8436" BottomMargin="165.8436" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="100.0000" Y="48.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-1502019580" Tag="248" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="22.5000" RightMargin="22.5000" TopMargin="8.0000" BottomMargin="8.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="24.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.5500" Y="0.6667" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1190.5256" Y="189.8436" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_2" ActionTag="1379199978" Tag="545" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="832.5767" RightMargin="-943.5767" TopMargin="-511.3705" BottomMargin="461.3705" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-560194305" Tag="249" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.0000" RightMargin="28.0000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4955" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="888.0767" Y="486.3705" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_3" ActionTag="1993447156" Tag="546" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="685.5145" RightMargin="-796.5145" TopMargin="-512.3707" BottomMargin="462.3707" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-2083855152" Tag="250" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.0000" RightMargin="28.0000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4955" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="741.0145" Y="487.3707" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_4" ActionTag="956745804" Tag="311" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="518.4108" RightMargin="-629.4108" TopMargin="-512.3703" BottomMargin="462.3703" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-1014459398" Tag="312" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.0000" RightMargin="28.0000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4955" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="573.9108" Y="487.3703" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_5" ActionTag="473101373" Tag="339" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="344.9372" RightMargin="-455.9372" TopMargin="-512.3703" BottomMargin="462.3703" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-116146269" Tag="340" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.0000" RightMargin="28.0000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4955" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="400.4372" Y="487.3703" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_6" ActionTag="-195072721" Tag="547" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="183.1883" RightMargin="-294.1883" TopMargin="-512.3705" BottomMargin="462.3705" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="1121434672" Tag="251" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.0000" RightMargin="28.0000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="2分" ctype="TextBMFontObjectData">
                        <Size X="55.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4955" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="238.6883" Y="487.3705" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_7" ActionTag="-822123710" Tag="548" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="186.6280" RightMargin="-297.6280" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-1707958678" Tag="252" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="18.5000" RightMargin="18.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="20分" ctype="TextBMFontObjectData">
                        <Size X="74.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.6667" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="242.1280" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_8" ActionTag="-602171137" Tag="549" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="343.3557" RightMargin="-454.3557" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="84215115" Tag="253" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.5000" RightMargin="28.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="5分" ctype="TextBMFontObjectData">
                        <Size X="54.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4865" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="398.8557" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_9" ActionTag="1964679957" Tag="648" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="501.5686" RightMargin="-612.5686" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-1133401585" Tag="649" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.5000" RightMargin="28.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="5分" ctype="TextBMFontObjectData">
                        <Size X="54.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4865" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="557.0686" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_10" ActionTag="1541070272" Tag="677" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="671.2179" RightMargin="-782.2179" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="2113943783" Tag="678" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.5000" RightMargin="28.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="5分" ctype="TextBMFontObjectData">
                        <Size X="54.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4865" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="726.7179" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_11" ActionTag="670019776" Tag="2355" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="828.7987" RightMargin="-939.7987" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="-220671878" Tag="2356" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.5000" RightMargin="28.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="5分" ctype="TextBMFontObjectData">
                        <Size X="54.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4865" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="884.2987" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_12" ActionTag="-1272051276" Tag="2357" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="988.0770" RightMargin="-1099.0770" TopMargin="-223.9014" BottomMargin="173.9014" Scale9Width="111" Scale9Height="50" ctype="ImageViewObjectData">
                    <Size X="111.0000" Y="50.0000" />
                    <Children>
                      <AbstractNodeData Name="bfLabel" ActionTag="1174287148" Tag="2358" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.5000" RightMargin="28.5000" TopMargin="9.0000" BottomMargin="9.0000" LabelText="5分" ctype="TextBMFontObjectData">
                        <Size X="54.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="55.5000" Y="25.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.4865" Y="0.6400" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/dn_yafen.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1043.5770" Y="198.9014" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/common/yafen_bg.png" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_RateSign" ActionTag="-1793161992" Tag="195" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="bflRateSign1" ActionTag="1373110584" CallBackType="Touch" Tag="202" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="1150.9088" RightMargin="-1229.9088" TopMargin="-205.8696" BottomMargin="173.8696" LabelText="1倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1190.4088" Y="189.8696" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign2" ActionTag="-121261686" Tag="203" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="839.3867" RightMargin="-918.3867" TopMargin="-501.6194" BottomMargin="469.6194" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="878.8867" Y="485.6194" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign3" ActionTag="-1458068105" Tag="204" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="691.5854" RightMargin="-770.5854" TopMargin="-501.6194" BottomMargin="469.6194" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="731.0854" Y="485.6194" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign4" ActionTag="-1510028051" Tag="326" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="521.9166" RightMargin="-600.9166" TopMargin="-501.6194" BottomMargin="469.6194" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="561.4166" Y="485.6194" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign5" ActionTag="1092696124" Tag="341" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="351.4232" RightMargin="-430.4232" TopMargin="-501.6194" BottomMargin="469.6194" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="390.9232" Y="485.6194" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign6" ActionTag="-542293730" Tag="205" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="186.1004" RightMargin="-265.1004" TopMargin="-501.6194" BottomMargin="469.6194" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="225.6004" Y="485.6194" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign7" ActionTag="-1071415798" Tag="206" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="194.3553" RightMargin="-273.3553" TopMargin="-221.2760" BottomMargin="189.2760" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="233.8553" Y="205.2760" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign8" ActionTag="360678314" Tag="207" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="351.7498" RightMargin="-430.7498" TopMargin="-221.2759" BottomMargin="189.2759" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="391.2498" Y="205.2759" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign9" ActionTag="649209771" Tag="650" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="507.2756" RightMargin="-586.2756" TopMargin="-221.2760" BottomMargin="189.2760" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="546.7756" Y="205.2760" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign10" ActionTag="1296441819" Tag="829" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="675.2993" RightMargin="-754.2993" TopMargin="-221.2760" BottomMargin="189.2760" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="714.7993" Y="205.2760" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign11" ActionTag="1412266351" Tag="2359" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="837.1545" RightMargin="-916.1545" TopMargin="-221.2759" BottomMargin="189.2759" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="876.6545" Y="205.2759" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="bflRateSign12" ActionTag="497020641" Tag="2360" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="994.7472" RightMargin="-1073.7472" TopMargin="-221.2762" BottomMargin="189.2762" LabelText="2倍" ctype="TextBMFontObjectData">
                    <Size X="79.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1034.2472" Y="205.2762" />
                    <Scale ScaleX="0.7500" ScaleY="0.7500" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_readySign" ActionTag="101596540" Tag="166" IconVisible="True" LeftMargin="-639.0532" RightMargin="639.0532" TopMargin="358.1543" BottomMargin="-358.1543" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Spr_readySign_1" ActionTag="-438855024" Tag="167" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="1124.7405" RightMargin="-1224.7405" TopMargin="-115.8058" BottomMargin="14.8058" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_11" ActionTag="722516305" Tag="860" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="503139163" Tag="861" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1174.7405" Y="65.3058" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_2" ActionTag="-484104388" Tag="183" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="772.1586" RightMargin="-872.1586" TopMargin="-674.7566" BottomMargin="573.7566" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_13" ActionTag="-2024412779" Tag="862" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="-207488606" Tag="863" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="822.1586" Y="624.2566" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_3" ActionTag="-1246231679" Tag="184" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="611.1379" RightMargin="-711.1379" TopMargin="-674.7566" BottomMargin="573.7566" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_15" ActionTag="-2109487584" Tag="864" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.7600" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="353845385" Tag="865" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="661.1379" Y="624.2566" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_4" ActionTag="-1537498553" Tag="327" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="437.4241" RightMargin="-537.4241" TopMargin="-674.7566" BottomMargin="573.7566" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_17" ActionTag="-710112833" Tag="866" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="318378346" Tag="867" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="487.4241" Y="624.2566" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_5" ActionTag="-1822878001" Tag="342" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="276.5274" RightMargin="-376.5274" TopMargin="-674.7566" BottomMargin="573.7566" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_19" ActionTag="-859161381" Tag="868" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="1608798175" Tag="869" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="326.5274" Y="624.2566" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_6" ActionTag="-1342896704" Tag="185" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="113.9520" RightMargin="-213.9520" TopMargin="-674.7566" BottomMargin="573.7566" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_21" ActionTag="1594021244" Tag="870" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="-623882018" Tag="871" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="163.9520" Y="624.2566" />
                    <Scale ScaleX="0.8000" ScaleY="0.6800" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_7" ActionTag="70844119" Tag="186" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="116.9456" RightMargin="-216.9456" TopMargin="-110.6466" BottomMargin="9.6466" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_23" ActionTag="375282914" Tag="872" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="-2065451199" Tag="873" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="166.9456" Y="60.1466" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_8" ActionTag="-2076044301" Tag="187" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="272.5846" RightMargin="-372.5846" TopMargin="-110.6466" BottomMargin="9.6466" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_25" ActionTag="-1012432297" Tag="874" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="415634182" Tag="875" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="322.5846" Y="60.1466" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_9" ActionTag="-538444090" Tag="651" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="439.2411" RightMargin="-539.2411" TopMargin="-110.6466" BottomMargin="9.6466" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_27" ActionTag="1787665851" Tag="876" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="1510454253" Tag="877" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="489.2411" Y="60.1466" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_10" ActionTag="1759189962" Tag="830" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="597.0175" RightMargin="-697.0175" TopMargin="-110.6466" BottomMargin="9.6466" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_29" ActionTag="-1307649121" Tag="878" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="116615791" Tag="879" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="647.0175" Y="60.1466" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_11" ActionTag="-252351939" Tag="2361" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="760.4965" RightMargin="-860.4965" TopMargin="-110.6466" BottomMargin="9.6466" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_29" ActionTag="1971525555" Tag="2362" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="-1666793562" Tag="2363" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="810.4965" Y="60.1466" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_12" ActionTag="569496334" Tag="2364" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="917.5959" RightMargin="-1017.5959" TopMargin="-110.6465" BottomMargin="9.6465" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_29" ActionTag="-1745728416" Tag="2365" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.2500" Y="1.4554" />
                        <FileData Type="Normal" Path="image/play/head_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Ready" ActionTag="-422089916" Tag="2366" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="10.5000" RightMargin="10.5000" TopMargin="29.5000" BottomMargin="29.5000" Scale9Width="79" Scale9Height="42" ctype="ImageViewObjectData">
                        <Size X="79.0000" Y="42.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="50.5000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.7900" Y="0.4158" />
                        <FileData Type="Normal" Path="image/play/ready.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="967.5959" Y="60.1465" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.0532" Y="-358.1543" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_ready" ActionTag="-1043617998" Tag="69" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-113.0000" RightMargin="-113.0000" TopMargin="-41.0000" BottomMargin="-41.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="82.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_ready.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Start" ActionTag="1963328489" Tag="186" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-113.0000" RightMargin="-113.0000" TopMargin="-41.0000" BottomMargin="-41.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="82.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_start.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_ViewFinalReport" ActionTag="-1685283406" Tag="1632" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="7.0000" RightMargin="-233.0000" TopMargin="-41.0000" BottomMargin="-41.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="162" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="82.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="120.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_viewreport.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_decisionBtn" ActionTag="1029724696" Tag="103" IconVisible="True" LeftMargin="-638.4216" RightMargin="638.4216" TopMargin="357.6983" BottomMargin="-357.6983" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_Score" Visible="False" ActionTag="-88846874" Tag="313" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1101.3477" RightMargin="-1101.3477" TopMargin="-382.8246" BottomMargin="382.8246" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnScore1" ActionTag="1475761906" Tag="314" IconVisible="False" LeftMargin="-160.0000" RightMargin="20.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1412152873" Tag="314" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="53.5000" RightMargin="53.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.2357" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-90.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore2" ActionTag="-873754383" Tag="316" IconVisible="False" LeftMargin="20.0000" RightMargin="-160.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1523471298" Tag="317" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="53.5000" RightMargin="53.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.2357" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="90.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScoreTui" ActionTag="1783766269" Tag="235" IconVisible="False" LeftMargin="200.0000" RightMargin="-340.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-439355585" Tag="236" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="53.5000" RightMargin="53.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.2357" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="270.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnDoubleScore" ActionTag="1820036963" Tag="752" IconVisible="False" LeftMargin="198.5000" RightMargin="-341.5000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="143.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="649889142" Tag="753" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="8.3200" BottomMargin="23.6800" LabelText="翻倍" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="71.5000" Y="39.6800" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6200" />
                            <PreSize X="0.6434" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="270.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1101.3477" Y="382.8246" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_QHScore" Visible="False" ActionTag="-1021963670" Tag="1735" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1101.3477" RightMargin="-1101.3477" TopMargin="-488.5114" BottomMargin="488.5114" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnScore1" ActionTag="-1404490267" Tag="1736" IconVisible="False" LeftMargin="-335.9999" RightMargin="195.9999" TopMargin="-32.5011" BottomMargin="-32.4989" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="557416525" Tag="1737" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-265.9999" Y="0.0011" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore2" ActionTag="-167171005" Tag="1738" IconVisible="False" LeftMargin="-183.2559" RightMargin="43.2559" TopMargin="-32.5006" BottomMargin="-32.4994" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-1756651449" Tag="1739" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-113.2559" Y="0.0006" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore3" ActionTag="345417850" Tag="1740" IconVisible="False" LeftMargin="-29.5117" RightMargin="-110.4883" TopMargin="-32.5012" BottomMargin="-32.4988" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-142721349" Tag="1741" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="4倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="40.4883" Y="0.0012" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore4" ActionTag="-2047783527" Tag="1742" IconVisible="False" LeftMargin="123.4886" RightMargin="-263.4886" TopMargin="-32.5022" BottomMargin="-32.4978" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1374129140" Tag="1743" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="8.7000" BottomMargin="24.3000" LabelText="5倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="40.3000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6200" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="193.4886" Y="0.0022" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1101.3477" Y="488.5114" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_ScoreSpecial" ActionTag="1528930579" Tag="4456" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.7755" RightMargin="-1094.7755" TopMargin="-415.4171" BottomMargin="415.4171" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnScore1" ActionTag="-18602203" Tag="4457" IconVisible="False" LeftMargin="-319.4177" RightMargin="209.4177" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="2116502040" Tag="4458" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="38.5000" RightMargin="38.5000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="1" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.3000" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-264.4177" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore2" ActionTag="916448280" Tag="4459" IconVisible="False" LeftMargin="-185.9285" RightMargin="75.9285" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1677167994" Tag="4460" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="38.5000" RightMargin="38.5000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="2" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.3000" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-130.9285" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore3" ActionTag="-88941350" Tag="4461" IconVisible="False" LeftMargin="-51.9767" RightMargin="-58.0233" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1847913975" Tag="4462" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="38.5000" RightMargin="38.5000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="3" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.3000" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="3.0233" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScore4" ActionTag="2129405463" Tag="4463" IconVisible="False" LeftMargin="81.5123" RightMargin="-191.5123" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-447388971" Tag="4464" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="38.5000" RightMargin="38.5000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="4" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.3000" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="136.5123" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnScoreTui" ActionTag="-1314193190" Tag="4465" IconVisible="False" LeftMargin="215.0009" RightMargin="-325.0009" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1178233516" Tag="4466" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="38.5000" RightMargin="38.5000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="2" ctype="TextBMFontObjectData">
                            <Size X="33.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.3000" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="270.0009" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnDoubleScore" ActionTag="1854174986" Tag="4467" IconVisible="False" LeftMargin="215.0009" RightMargin="-325.0009" TopMargin="-31.5000" BottomMargin="-31.5000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="111" Scale9Height="41" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="110.0000" Y="63.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1540652910" Tag="4468" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="9.0000" RightMargin="9.0000" TopMargin="7.6124" BottomMargin="23.3876" LabelText="翻倍" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="55.0000" Y="39.3876" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6252" />
                            <PreSize X="0.8364" Y="0.5079" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="270.0009" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/play/btn_common1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.7755" Y="415.4171" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.4216" Y="-357.6983" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_RateBtn" ActionTag="-290125231" Tag="653" IconVisible="True" LeftMargin="-638.4216" RightMargin="638.4216" TopMargin="357.6983" BottomMargin="-357.6983" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_Rate1" ActionTag="-1517974140" Tag="384" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.6711" RightMargin="-1094.6711" TopMargin="-324.8611" BottomMargin="324.8611" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnRate2" ActionTag="1073775253" Tag="387" IconVisible="False" LeftMargin="-97.5000" RightMargin="-45.5000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="143.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="2026479718" Tag="388" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="7.0400" BottomMargin="24.9600" LabelText="不抢" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="71.5000" Y="40.9600" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6400" />
                            <PreSize X="0.6434" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-26.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate1" ActionTag="-1561578132" Tag="385" IconVisible="False" LeftMargin="92.0000" RightMargin="-232.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-605737703" Tag="386" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="162.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.6711" Y="324.8611" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Rate2" Visible="False" ActionTag="101459635" Tag="665" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.6714" RightMargin="-1094.6714" TopMargin="-380.7292" BottomMargin="380.7292" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnRate3" ActionTag="2057851452" Tag="669" IconVisible="False" LeftMargin="-177.5000" RightMargin="34.5000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="143.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="658699575" Tag="670" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="7.0400" BottomMargin="24.9600" LabelText="不抢" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="71.5000" Y="40.9600" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6400" />
                            <PreSize X="0.6434" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-106.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate1" ActionTag="-819916113" Tag="666" IconVisible="False" RightMargin="-140.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-1171529745" Tag="668" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="70.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate2" ActionTag="1928044608" Tag="389" IconVisible="False" LeftMargin="178.0000" RightMargin="-318.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1319383594" Tag="390" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="248.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.6714" Y="380.7292" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Rate3" Visible="False" ActionTag="-179003127" Tag="671" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.6714" RightMargin="-1094.6714" TopMargin="-237.1371" BottomMargin="237.1371" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnRate4" ActionTag="-1669198574" Tag="676" IconVisible="False" LeftMargin="-95.5000" RightMargin="-47.5000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="143.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1198644128" Tag="677" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="7.0400" BottomMargin="24.9600" LabelText="不抢" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="71.5000" Y="40.9600" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6400" />
                            <PreSize X="0.6434" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-24.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate1" ActionTag="-1150400249" Tag="672" IconVisible="False" LeftMargin="72.0000" RightMargin="-212.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-278119846" Tag="673" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="142.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate2" ActionTag="-1290166900" Tag="674" IconVisible="False" LeftMargin="238.0000" RightMargin="-378.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="874099884" Tag="675" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="308.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate3" ActionTag="-1649890835" Tag="391" IconVisible="False" LeftMargin="404.0000" RightMargin="-544.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-980766525" Tag="392" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="30.5000" RightMargin="30.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="3倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.5643" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="474.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.6714" Y="237.1371" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Rate4" Visible="False" ActionTag="1134242781" Tag="393" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.6721" RightMargin="-1094.6721" TopMargin="-191.2682" BottomMargin="191.2682" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnRate5" ActionTag="1266763433" Tag="400" IconVisible="False" LeftMargin="-70.0000" RightMargin="-60.0000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="130.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="1041525380" Tag="401" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="19.0000" RightMargin="19.0000" TopMargin="7.0400" BottomMargin="24.9600" LabelText="不抢" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="65.0000" Y="40.9600" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6400" />
                            <PreSize X="0.7077" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-5.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate1" ActionTag="-525040759" Tag="394" IconVisible="False" LeftMargin="67.5580" RightMargin="-197.5580" TopMargin="-32.5001" BottomMargin="-32.4999" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="130.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-1748779536" Tag="395" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="1倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="65.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.6077" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="132.5580" Y="0.0001" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate2" ActionTag="-1246458936" Tag="396" IconVisible="False" LeftMargin="205.1157" RightMargin="-335.1157" TopMargin="-32.5001" BottomMargin="-32.4999" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="130.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-535119889" Tag="397" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="2倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="65.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.6077" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="270.1157" Y="0.0001" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate3" ActionTag="-782814539" Tag="398" IconVisible="False" LeftMargin="342.6736" RightMargin="-472.6736" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="130.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="837417330" Tag="399" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="3倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="65.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.6077" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="407.6736" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate4" ActionTag="-1323517642" Tag="402" IconVisible="False" LeftMargin="477.6732" RightMargin="-607.6732" TopMargin="-32.4999" BottomMargin="-32.5001" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="130.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-1146013772" Tag="403" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="4倍" ctype="TextBMFontObjectData">
                            <Size X="79.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="65.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.6077" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="542.6732" Y="-0.0001" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.6721" Y="191.2682" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Rate5" Visible="False" ActionTag="-1335260920" Tag="618" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" LeftMargin="1094.6711" RightMargin="-1094.6711" TopMargin="-325.0738" BottomMargin="325.0738" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="btnRate2" ActionTag="1618218749" Tag="621" IconVisible="False" LeftMargin="-97.5000" RightMargin="-45.5000" TopMargin="-32.0000" BottomMargin="-32.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="143.0000" Y="64.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-79753470" Tag="622" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="7.0400" BottomMargin="24.9600" LabelText="不抢" ctype="TextBMFontObjectData">
                            <Size X="92.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="71.5000" Y="40.9600" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6400" />
                            <PreSize X="0.6434" Y="0.5000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-26.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="btnRate1" ActionTag="-253050078" Tag="619" IconVisible="False" LeftMargin="92.0000" RightMargin="-232.0000" TopMargin="-32.5000" BottomMargin="-32.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="202" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="140.0000" Y="65.0000" />
                        <Children>
                          <AbstractNodeData Name="bfLabel" ActionTag="-1445519606" Tag="620" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="10.0000" BottomMargin="23.0000" LabelText="抢" ctype="TextBMFontObjectData">
                            <Size X="46.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="70.0000" Y="39.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.6000" />
                            <PreSize X="0.3286" Y="0.4923" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/dn_score.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="162.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <NormalFileData Type="Normal" Path="image/common/an11_n.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="1094.6711" Y="325.0738" />
                    <Scale ScaleX="0.8600" ScaleY="0.8600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.4216" Y="-357.6983" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_yuyin" Visible="False" ActionTag="-37081834" Tag="95" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <AnchorPoint />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Bottom_Right" ActionTag="-1238204125" Tag="2773" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="1280.0000" BottomMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Btn_Voice" ActionTag="-1954168454" Tag="98" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-76.9752" RightMargin="1.9752" TopMargin="6.0653" BottomMargin="-76.0653" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="55" Scale9Height="62" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-39.4752" Y="-41.0653" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_voice.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Chat" ActionTag="664548959" Tag="57" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-378.0052" RightMargin="303.0052" TopMargin="6.0653" BottomMargin="-76.0653" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="55" Scale9Height="62" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-340.5052" Y="-41.0653" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_chat.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_inviteFriend" ActionTag="-1179697185" Tag="174" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-299.2876" RightMargin="73.2876" TopMargin="58.1348" BottomMargin="-139.1348" TouchEnable="True" FontSize="22" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="59" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="81.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-186.2876" Y="-98.6348" />
                <Scale ScaleX="0.7500" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                <TextColor A="255" R="255" G="255" B="255" />
                <NormalFileData Type="Normal" Path="image/play/btn_invite.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_RubCard" ActionTag="-1489302290" Tag="428" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-349.7058" RightMargin="169.7058" TopMargin="59.3864" BottomMargin="-139.3864" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="165" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="180.0000" Y="80.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-259.7058" Y="-99.3864" />
                <Scale ScaleX="0.9500" ScaleY="0.9500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_rubbing_card.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_OpenCard" Visible="False" ActionTag="795885099" Tag="445" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-267.6953" RightMargin="87.6953" TopMargin="57.2697" BottomMargin="-137.2697" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="165" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="180.0000" Y="80.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-177.6953" Y="-97.2697" />
                <Scale ScaleX="0.9500" ScaleY="0.9500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_open_card.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_ShowCard" Visible="False" ActionTag="2049745398" Tag="188" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-266.6376" RightMargin="86.6376" TopMargin="58.6572" BottomMargin="-138.6572" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="165" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="180.0000" Y="80.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-176.6376" Y="-98.6572" />
                <Scale ScaleX="0.9500" ScaleY="0.9500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_show_card.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_GuanZhan" ActionTag="1550821891" Tag="695" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="-352.5857" RightMargin="173.5857" TopMargin="49.2069" BottomMargin="-122.2069" Scale9Width="179" Scale9Height="73" ctype="ImageViewObjectData">
                <Size X="179.0000" Y="73.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-263.0857" Y="-85.7069" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/play/guanzhan.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="1280.0000" Y="720.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" Y="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Trusteeship" Visible="False" ActionTag="1979858754" Tag="2688" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_BG" ActionTag="-2120521777" Tag="2689" IconVisible="False" LeftMargin="-780.0000" RightMargin="-780.0000" TopMargin="-480.0000" BottomMargin="-480.0000" TouchEnable="True" Scale9Width="1280" Scale9Height="718" ctype="ImageViewObjectData">
                <Size X="1560.0000" Y="960.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/trusteeship/bg_1.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Cancel" ActionTag="1849554824" Tag="2690" RotationSkewX="-90.0000" RotationSkewY="-90.0000" IconVisible="False" LeftMargin="328.9294" RightMargin="-561.9294" TopMargin="-238.3721" BottomMargin="167.3721" TouchEnable="True" FontSize="40" ButtonText="取消托管" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="203" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="233.0000" Y="71.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="445.4294" Y="202.8721" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
                <TextColor A="255" R="255" G="255" B="255" />
                <NormalFileData Type="Normal" Path="image/common/an12_n.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>