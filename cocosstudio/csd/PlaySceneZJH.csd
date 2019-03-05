<GameFile>
  <PropertyGroup Name="PlaySceneZJH" Type="Layer" ID="2722f513-fb27-467b-884c-ab983b55b359" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="130" Speed="0.5000" ActivedAnimationName="animation_fail_left">
        <Timeline ActionTag="364643579" Property="Position">
          <PointFrame FrameIndex="60" X="99.3499" Y="132.5033">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="85" X="99.3469" Y="49.6519">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="90" X="99.3502" Y="-68.8987">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="364643579" Property="Scale">
          <ScaleFrame FrameIndex="85" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="364643579" Property="RotationSkew">
          <ScaleFrame FrameIndex="85" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1221885161" Property="Position">
          <PointFrame FrameIndex="100" X="99.3502" Y="132.3500">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="125" X="99.3469" Y="49.6519">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="130" X="99.3469" Y="-68.9000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1221885161" Property="Scale">
          <ScaleFrame FrameIndex="100" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="125" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="130" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1221885161" Property="RotationSkew">
          <ScaleFrame FrameIndex="100" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="125" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="130" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1063570984" Property="Position">
          <PointFrame FrameIndex="0" X="640.0000" Y="360.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="15" X="640.0000" Y="360.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="25" Tween="False" X="199.9983" Y="398.0000" />
          <PointFrame FrameIndex="30" X="642.0000" Y="386.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="45" X="642.0000" Y="386.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="55" X="1084.0000" Y="398.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1063570984" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="15" X="1.7000" Y="2.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="25" Tween="False" X="0.4000" Y="0.4000" />
          <ScaleFrame FrameIndex="30" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="45" X="1.7000" Y="2.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="55" X="0.4000" Y="0.4000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1063570984" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="15" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="25" Tween="False" X="0.0000" Y="0.0000" />
          <ScaleFrame FrameIndex="30" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="45" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="55" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="animation_win_left" StartIndex="0" EndIndex="25">
          <RenderColor A="255" R="144" G="238" B="144" />
        </AnimationInfo>
        <AnimationInfo Name="animation_win_right" StartIndex="30" EndIndex="55">
          <RenderColor A="255" R="0" G="255" B="255" />
        </AnimationInfo>
        <AnimationInfo Name="animation_fail_left" StartIndex="60" EndIndex="90">
          <RenderColor A="255" R="148" G="0" B="211" />
        </AnimationInfo>
        <AnimationInfo Name="animation_fail_right" StartIndex="100" EndIndex="130">
          <RenderColor A="255" R="128" G="128" B="0" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Layer" Tag="5" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="Img_Bg" ActionTag="-1198334963" CallBackType="Click" Tag="9" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-140.0000" RightMargin="-140.0000" TopMargin="-120.0000" BottomMargin="-120.0000" Scale9Width="1560" Scale9Height="960" ctype="ImageViewObjectData">
            <Size X="1560.0000" Y="960.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.2188" Y="1.3333" />
            <FileData Type="Normal" Path="image/play/play_bg_2.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Spine" ActionTag="2051521167" Tag="927" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <AnchorPoint />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Top_Left" ActionTag="-269987491" Tag="8327" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" RightMargin="1280.0000" BottomMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_RoundBg" ActionTag="-1775856643" Tag="624" IconVisible="True" LeftMargin="71.6788" RightMargin="-71.6788" TopMargin="18.7476" BottomMargin="-18.7476" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Label_Time" ActionTag="-1996980397" Tag="142" IconVisible="False" LeftMargin="-64.5000" RightMargin="15.5000" TopMargin="-12.0000" BottomMargin="-12.0000" FontSize="20" LabelText="12:00" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="49.0000" Y="24.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="-40.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_Round" ActionTag="303143036" Tag="139" IconVisible="False" LeftMargin="12.0000" RightMargin="-82.0000" TopMargin="-12.0000" BottomMargin="-12.0000" FontSize="20" LabelText="10/20局" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="70.0000" Y="24.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="12.0000" />
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
                <Position X="71.6788" Y="-18.7476" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_SetBg" ActionTag="1150895753" Tag="623" IconVisible="True" LeftMargin="78.5780" RightMargin="-78.5780" TopMargin="50.7477" BottomMargin="-50.7477" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Label_Room" ActionTag="1600008473" Tag="144" IconVisible="False" LeftMargin="-75.0000" RightMargin="7.0000" TopMargin="-12.0000" BottomMargin="-12.0000" FontSize="20" LabelText="房间号:" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="68.0000" Y="24.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="-75.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_RoomNumber" ActionTag="-229489714" Tag="145" IconVisible="False" LeftMargin="12.0000" RightMargin="-81.0000" TopMargin="-12.0000" BottomMargin="-12.0000" FontSize="20" LabelText="888888" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="69.0000" Y="24.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="12.0000" />
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
                <Position X="78.5780" Y="-50.7477" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Info" ActionTag="-1937653221" Tag="1011" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="8.5774" RightMargin="-68.5774" TopMargin="73.2472" BottomMargin="-134.2472" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="30" Scale9Height="39" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="60.0000" Y="61.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="38.5774" Y="-103.7472" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_roominfo.png" Plist="" />
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
          <AbstractNodeData Name="Node_Top_Right" ActionTag="-1361826783" Tag="8328" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="1280.0000" BottomMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Img_NetworkBg" ActionTag="-1571761869" Tag="733" IconVisible="False" LeftMargin="-177.0706" RightMargin="7.0706" TopMargin="5.5554" BottomMargin="-45.5554" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                <Size X="170.0000" Y="40.0000" />
                <Children>
                  <AbstractNodeData Name="Img_Network" ActionTag="-1431634142" Tag="734" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="12.4000" RightMargin="124.6000" TopMargin="7.0000" BottomMargin="7.0000" Scale9Width="33" Scale9Height="26" ctype="ImageViewObjectData">
                    <Size X="33.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="28.9000" Y="20.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.1700" Y="0.5000" />
                    <PreSize X="0.1941" Y="0.6500" />
                    <FileData Type="MarkedSubImage" Path="image/play/network_13.png" Plist="image/play/netandbattery.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_BatteryBg" ActionTag="1914160439" Tag="735" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="123.1000" RightMargin="10.9000" TopMargin="8.0000" BottomMargin="8.0000" Scale9Width="36" Scale9Height="24" ctype="ImageViewObjectData">
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
                    <Position X="141.1000" Y="20.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.8300" Y="0.5000" />
                    <PreSize X="0.2118" Y="0.6000" />
                    <FileData Type="MarkedSubImage" Path="image/play/battery_bg1.png" Plist="image/play/netandbattery.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Label_Network" ActionTag="-685370083" Tag="736" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="42.0000" RightMargin="59.0000" TopMargin="8.0000" BottomMargin="8.0000" FontSize="20" LabelText="1000ms" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="69.0000" Y="24.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="76.5000" Y="20.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="182" B="0" />
                    <PrePosition X="0.4500" Y="0.5000" />
                    <PreSize X="0.4059" Y="0.6000" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="1.0000" />
                <Position X="-92.0706" Y="-5.5554" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_setting" ActionTag="2139061361" Tag="58" IconVisible="False" LeftMargin="-87.5705" RightMargin="12.5705" TopMargin="50.5553" BottomMargin="-120.5553" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="39" Scale9Height="48" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-50.0705" Y="-85.5553" />
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
            <Position X="1280.0000" Y="720.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" Y="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Center_Center" ActionTag="-1873712051" Tag="8330" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="lblCmpTips" ActionTag="-1084565660" Tag="1256" IconVisible="False" LeftMargin="-229.5000" RightMargin="-229.5000" TopMargin="-184.5000" BottomMargin="155.5000" FontSize="24" LabelText="两轮后系统将从庄家下一位开始逆时针比牌" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="459.0000" Y="29.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="170.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="251" G="233" B="12" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_BgWaitingTip" Visible="False" ActionTag="339301504" Tag="395" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-171.0000" RightMargin="-171.0000" TopMargin="-197.5000" BottomMargin="152.5000" Scale9Enable="True" LeftEage="102" RightEage="102" TopEage="5" BottomEage="5" Scale9OriginX="102" Scale9OriginY="5" Scale9Width="107" Scale9Height="35" ctype="ImageViewObjectData">
                <Size X="342.0000" Y="45.0000" />
                <Children>
                  <AbstractNodeData Name="Label_WatingTip" ActionTag="-1174168511" Tag="378" IconVisible="False" LeftMargin="-17.0000" RightMargin="-17.0000" TopMargin="7.0000" BottomMargin="8.0000" FontSize="24" LabelText="本局已经开始，请等待下局开始......" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="376.0000" Y="30.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="171.0000" Y="23.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="165" B="0" />
                    <PrePosition X="0.5000" Y="0.5111" />
                    <PreSize X="1.0994" Y="0.6667" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="175.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/common/waiting_tip_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Img_Golds_Pool" ActionTag="-1413788240" Tag="1182" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-222.5000" RightMargin="-222.5000" TopMargin="-76.5000" BottomMargin="-136.5000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="445.0000" Y="213.0000" />
                <Children>
                  <AbstractNodeData Name="Img_Pool_Desc" ActionTag="804249642" Tag="2767" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="162.5000" RightMargin="162.5000" TopMargin="-39.3000" BottomMargin="216.3000" LeftEage="35" RightEage="35" TopEage="11" BottomEage="11" Scale9OriginX="35" Scale9OriginY="11" Scale9Width="38" Scale9Height="14" ctype="ImageViewObjectData">
                    <Size X="120.0000" Y="36.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Golds_Num" ActionTag="672556974" Tag="2768" IconVisible="False" LeftMargin="40.0000" RightMargin="64.0000" TopMargin="4.5000" BottomMargin="4.5000" FontSize="23" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="16.0000" Y="27.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="40.0000" Y="18.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.3333" Y="0.5000" />
                        <PreSize X="0.1333" Y="0.7500" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Text_Tuns_Num" ActionTag="99472133" Tag="2769" IconVisible="False" LeftMargin="2.0000" RightMargin="28.0000" TopMargin="-32.0000" BottomMargin="44.0000" FontSize="20" LabelText="第 0/10 轮" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="90.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="47.0000" Y="56.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.3917" Y="1.5556" />
                        <PreSize X="0.7500" Y="0.6667" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon_0" ActionTag="671114179" Tag="1183" IconVisible="False" LeftMargin="-13.5000" RightMargin="96.5000" TopMargin="-7.0000" BottomMargin="-5.0000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="24" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="48.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0417" Y="0.5278" />
                        <PreSize X="0.3083" Y="1.3333" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipallnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="222.5000" Y="234.3000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="1.1000" />
                    <PreSize X="0.2697" Y="0.1690" />
                    <FileData Type="Normal" Path="image/play_zjh/ui/imgBgNum.png" Plist="" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-30.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_PlayerInfo" ActionTag="-564814813" Tag="123456" IconVisible="True" LeftMargin="-638.8246" RightMargin="638.8246" TopMargin="360.5206" BottomMargin="-360.5206" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_playerInfo_1" ActionTag="-2147180752" Tag="147" IconVisible="True" LeftMargin="178.0000" RightMargin="-178.0000" TopMargin="-108.0000" BottomMargin="108.0000" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="272548655" Tag="278" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1331798555" Tag="150" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="-1194977162" Tag="153" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="407521844" Tag="159" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="-623065152" VisibleForFrame="False" Tag="329" IconVisible="False" LeftMargin="84.3654" RightMargin="-162.3654" TopMargin="-0.5508" BottomMargin="-23.4492" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
                        <AnchorPoint ScaleY="0.5000" />
                        <Position X="84.3654" Y="-11.4492" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Label_AddScore" ActionTag="544338399" Tag="483" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="-5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="178.0000" Y="108.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_2" ActionTag="-2095991133" Tag="104" IconVisible="True" LeftMargin="1176.7004" RightMargin="-1176.7004" TopMargin="-326.2378" BottomMargin="326.2378" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="852522241" Tag="279" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="-1471377261" Tag="408" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="-1929339138" Tag="409" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="-1294567285" Tag="160" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="1870094060" Tag="330" IconVisible="False" LeftMargin="-142.0000" RightMargin="64.0000" TopMargin="-6.0000" BottomMargin="-18.0000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-390275753" Tag="484" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="1176.7004" Y="326.2378" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_3" ActionTag="-1129560041" Tag="287" IconVisible="True" LeftMargin="1120.0000" RightMargin="-1120.0000" TopMargin="-542.0000" BottomMargin="542.0000" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="-1300077664" Tag="291" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="480102136" Tag="293" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="246719448" Tag="295" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="-1666762633" Tag="296" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="1925184033" Tag="297" IconVisible="False" LeftMargin="-142.0000" RightMargin="64.0000" TopMargin="-6.0000" BottomMargin="-18.0000" FontSize="20" LabelText="旁观中..." HorizontalAlignmentType="HT_Right" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_AddScore" ActionTag="943976042" Tag="299" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="1120.0000" Y="542.0000" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_4" ActionTag="1447082605" Tag="120" IconVisible="True" LeftMargin="574.7543" RightMargin="-574.7543" TopMargin="-635.5210" BottomMargin="635.5210" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="-496190687" Tag="281" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="-351697795" Tag="420" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="-1100260836" Tag="421" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="-2024174746" Tag="162" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="1633875679" Tag="332" IconVisible="False" LeftMargin="70.0000" RightMargin="-148.0000" TopMargin="-4.0000" BottomMargin="-20.0000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1309758234" Tag="486" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="574.7543" Y="635.5210" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_5" ActionTag="177839079" Tag="136" IconVisible="True" LeftMargin="159.9205" RightMargin="-159.9205" TopMargin="-542.0000" BottomMargin="542.0000" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="-1032456386" Tag="283" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="654745457" Tag="432" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="-1511634832" Tag="433" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="-1729546635" Tag="164" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="-685483666" Tag="334" IconVisible="False" LeftMargin="70.0000" RightMargin="-148.0000" TopMargin="-4.0000" BottomMargin="-20.0000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_AddScore" ActionTag="-680450526" Tag="488" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="159.9205" Y="542.0000" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_playerInfo_6" ActionTag="1678783757" Tag="653" IconVisible="True" LeftMargin="111.4997" RightMargin="-111.4997" TopMargin="-318.7719" BottomMargin="318.7719" ctype="SingleNodeObjectData">
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
                          <AbstractNodeData Name="Spr_Head" ActionTag="-605159622" Tag="657" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                            <Size X="96.0000" Y="96.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="48.0000" Y="48.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="1.0000" Y="1.0000" />
                            <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                          <AbstractNodeData Name="Label_Nick" ActionTag="-2063314510" Tag="659" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="82.0000" Y="24.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="47.0000" Y="14.0000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.8723" Y="0.8571" />
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
                      <AbstractNodeData Name="Label_Score" ActionTag="-1333938990" Tag="661" IconVisible="False" LeftMargin="-36.0000" RightMargin="-36.0000" TopMargin="55.5000" BottomMargin="-92.5000" FontSize="30" LabelText="5000" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="72.0000" Y="37.0000" />
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
                      <AbstractNodeData Name="Label_offline" ActionTag="-1724739109" Tag="662" IconVisible="False" LeftMargin="-21.0000" RightMargin="-21.0000" TopMargin="40.0000" BottomMargin="-64.0000" FontSize="20" LabelText="离线" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="42.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_Wait" ActionTag="-1003297593" Tag="663" IconVisible="False" LeftMargin="70.0000" RightMargin="-148.0000" TopMargin="-4.0000" BottomMargin="-20.0000" FontSize="20" LabelText="旁观中..." ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="78.0000" Y="24.0000" />
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
                      <AbstractNodeData Name="Label_AddScore" ActionTag="1830008692" Tag="665" IconVisible="False" LeftMargin="-60.5000" RightMargin="-60.5000" TopMargin="-25.5000" BottomMargin="-25.5000" FontSize="40" LabelText="+5000" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="121.0000" Y="51.0000" />
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
                    <Position X="111.4997" Y="318.7719" />
                    <Scale ScaleX="0.7600" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.8246" Y="-360.5206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_play" ActionTag="1862310019" Tag="159" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="pCard1" ActionTag="1358611441" Tag="281" IconVisible="True" PositionPercentXEnabled="True" TopMargin="258.0000" BottomMargin="-258.0000" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="1605723707" Tag="100" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-389.0000" RightMargin="263.0000" TopMargin="-87.5000" BottomMargin="-87.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="126.0000" Y="175.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-326.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1130501432" Tag="101" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-267.0000" RightMargin="141.0000" TopMargin="-87.5000" BottomMargin="-87.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="126.0000" Y="175.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-204.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1409795471" Tag="102" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-145.0000" RightMargin="19.0000" TopMargin="-87.5000" BottomMargin="-87.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="126.0000" Y="175.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-82.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="-734411218" Tag="163" IconVisible="False" LeftMargin="-256.0002" RightMargin="150.0002" TopMargin="-66.4998" BottomMargin="31.4998" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="-1845163363" Tag="161" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="26.5000" RightMargin="26.5000" TopMargin="1.5000" BottomMargin="1.5000" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-203.0002" Y="48.9998" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="-1647153525" Tag="321" IconVisible="False" LeftMargin="-342.9603" RightMargin="53.9603" TopMargin="17.9059" BottomMargin="-75.9059" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-198.4603" Y="-46.9059" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_6.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position Y="-258.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard2" ActionTag="-2035422733" Tag="282" IconVisible="True" LeftMargin="390.0000" RightMargin="-390.0000" TopMargin="36.7617" BottomMargin="-36.7617" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-2119618406" Tag="88" IconVisible="False" LeftMargin="-53.0000" RightMargin="-13.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="1868195015" Tag="89" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-18.0000" RightMargin="-48.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="15.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-526944076" Tag="90" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="2080474129" Tag="322" IconVisible="False" LeftMargin="-127.7020" RightMargin="-161.2980" TopMargin="-3.2533" BottomMargin="-54.7467" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="16.7980" Y="-25.7467" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_1.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="17723345" Tag="164" IconVisible="False" LeftMargin="-43.0000" RightMargin="-63.0000" TopMargin="-37.2545" BottomMargin="2.2545" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="1909991873" Tag="165" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="26.5000" RightMargin="26.5000" TopMargin="1.5000" BottomMargin="1.5000" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="10.0000" Y="19.7545" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="390.0000" Y="-36.7617" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard3" ActionTag="-530326075" Tag="300" IconVisible="True" LeftMargin="333.0000" RightMargin="-333.0000" TopMargin="-178.0000" BottomMargin="178.0000" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="-2142746723" Tag="303" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-53.0000" RightMargin="-13.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="538607423" Tag="304" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-18.0000" RightMargin="-48.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="15.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1286449451" Tag="305" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="17.0000" RightMargin="-83.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="-644199779" Tag="323" IconVisible="False" LeftMargin="-129.4797" RightMargin="-159.5203" TopMargin="-3.2296" BottomMargin="-54.7704" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="15.0203" Y="-25.7704" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_2.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="1699407529" CallBackType="Click" Tag="308" IconVisible="False" LeftMargin="-38.0000" RightMargin="-68.0000" TopMargin="-38.7045" BottomMargin="3.7045" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="-1242675772" Tag="309" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="26.5000" RightMargin="26.5000" TopMargin="1.5000" BottomMargin="1.5000" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="15.0000" Y="21.2045" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="333.0000" Y="178.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard4" ActionTag="242161140" Tag="284" IconVisible="True" LeftMargin="49.7598" RightMargin="-49.7598" TopMargin="-269.5200" BottomMargin="269.5200" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="imgCrad1" ActionTag="281200886" Tag="72" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-63.0000" RightMargin="-3.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-30.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad2" ActionTag="1965169167" Tag="73" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-28.0000" RightMargin="-38.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1858087972" Tag="74" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="7.0000" RightMargin="-73.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="40.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="-327633500" Tag="324" IconVisible="False" LeftMargin="-139.4720" RightMargin="-149.5280" TopMargin="-3.3292" BottomMargin="-54.6708" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0280" Y="-25.6708" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_3.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="-1298424822" Tag="168" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-53.0000" RightMargin="-53.0000" TopMargin="-38.7051" BottomMargin="3.7051" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="438177392" Tag="169" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="27.1572" RightMargin="25.8428" TopMargin="1.6877" BottomMargin="1.3123" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5820" ScaleY="0.4631" />
                            <Position X="58.0032" Y="16.1315" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5472" Y="0.4609" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position Y="21.2051" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="49.7598" Y="269.5200" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard5" ActionTag="-620441400" Tag="286" IconVisible="True" LeftMargin="-344.0784" RightMargin="344.0784" TopMargin="-175.0000" BottomMargin="175.0000" ctype="SingleNodeObjectData">
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
                      <AbstractNodeData Name="imgCrad2" ActionTag="-1084706604" Tag="94" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-18.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="-1645177011" Tag="95" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-13.0000" RightMargin="-53.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="-364727939" Tag="325" IconVisible="False" LeftMargin="-157.8957" RightMargin="-131.1043" TopMargin="-3.3532" BottomMargin="-54.6468" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-13.3957" Y="-25.6468" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_4.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="1107164487" Tag="172" IconVisible="False" LeftMargin="-68.0000" RightMargin="-38.0000" TopMargin="-38.7020" BottomMargin="3.7020" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="13648181" Tag="173" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="26.5000" RightMargin="26.5000" TopMargin="1.5000" BottomMargin="1.5000" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.0000" Y="21.2020" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-344.0784" Y="175.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="pCard6" ActionTag="-1650995708" Tag="666" IconVisible="True" LeftMargin="-394.4867" RightMargin="394.4867" TopMargin="46.2300" BottomMargin="-46.2300" ctype="SingleNodeObjectData">
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
                      <AbstractNodeData Name="imgCrad2" ActionTag="-48870113" Tag="668" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-18.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgCrad3" ActionTag="1241435493" Tag="669" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-13.0000" RightMargin="-53.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                        <Size X="66.0000" Y="93.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_CardType" ActionTag="-1742587148" Tag="326" IconVisible="False" LeftMargin="-160.4371" RightMargin="-128.5629" TopMargin="-2.5481" BottomMargin="-55.4519" Scale9Width="289" Scale9Height="58" ctype="ImageViewObjectData">
                        <Size X="289.0000" Y="58.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.9371" Y="-26.4519" />
                        <Scale ScaleX="0.5000" ScaleY="0.5000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="MarkedSubImage" Path="image/play_zjh/poker_type_5.png" Plist="image/play_zjh/play_zjh.plist" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Img_Tips" ActionTag="-1845559810" Tag="674" IconVisible="False" LeftMargin="-68.0000" RightMargin="-38.0000" TopMargin="-37.9797" BottomMargin="2.9797" Scale9Width="106" Scale9Height="35" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="35.0000" />
                        <Children>
                          <AbstractNodeData Name="Lbl_Tips" ActionTag="248895593" Tag="675" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="26.5000" RightMargin="26.5000" TopMargin="1.5000" BottomMargin="1.5000" FontSize="24" LabelText="看牌" OutlineSize="2" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                            <Size X="53.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="53.0000" Y="17.5000" />
                            <Scale ScaleX="1.0000" ScaleY="1.0000" />
                            <CColor A="255" R="255" G="212" B="0" />
                            <PrePosition X="0.5000" Y="0.5000" />
                            <PreSize X="0.5000" Y="0.9143" />
                            <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                            <OutlineColor A="255" R="26" G="26" B="26" />
                            <ShadowColor A="255" R="110" G="110" B="110" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="-15.0000" Y="20.4797" />
                        <Scale ScaleX="0.7500" ScaleY="0.7500" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition />
                        <PreSize X="0.0000" Y="0.0000" />
                        <FileData Type="Normal" Path="image/common/info_bg.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-394.4867" Y="-46.2300" />
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
              <AbstractNodeData Name="Node_pledgeSign" ActionTag="-357394960" Tag="497" IconVisible="True" LeftMargin="-638.8246" RightMargin="638.8246" TopMargin="360.5206" BottomMargin="-360.5206" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Img_pledgeSign_1" ActionTag="-897386010" Tag="544" IconVisible="False" LeftMargin="376.7846" RightMargin="-488.7846" TopMargin="-223.7637" BottomMargin="185.7637" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="1153620250" Tag="2747" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="-637840485" Tag="337" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="432.7846" Y="204.7637" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_2" ActionTag="1379199978" Tag="545" IconVisible="False" LeftMargin="989.6947" RightMargin="-1101.6947" TopMargin="-278.2378" BottomMargin="240.2378" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="-897089971" Tag="2746" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="101455272" Tag="339" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1045.6947" Y="259.2378" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_3" ActionTag="956745804" Tag="311" IconVisible="False" LeftMargin="936.0153" RightMargin="-1048.0154" TopMargin="-493.1386" BottomMargin="455.1386" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="-1631389312" Tag="2759" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="153818263" Tag="340" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="992.0153" Y="474.1386" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_4" ActionTag="-195072721" Tag="547" IconVisible="False" LeftMargin="639.5892" RightMargin="-751.5892" TopMargin="-583.7285" BottomMargin="545.7284" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="744801042" Tag="2761" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="1523036586" Tag="341" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5415" ScaleY="0.4782" />
                    <Position X="700.2372" Y="563.9000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_5" ActionTag="-602171137" Tag="549" IconVisible="False" LeftMargin="224.9196" RightMargin="-336.9196" TopMargin="-475.0000" BottomMargin="437.0000" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="1461535342" Tag="2763" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="-68954111" Tag="342" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="280.9196" Y="456.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Img_pledgeSign_6" ActionTag="1541070272" Tag="677" IconVisible="False" LeftMargin="175.4949" RightMargin="-287.4949" TopMargin="-264.7700" BottomMargin="226.7700" Scale9Width="112" Scale9Height="38" ctype="ImageViewObjectData">
                    <Size X="112.0000" Y="38.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_Bet_Score" ActionTag="857395387" Tag="2765" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="47.0000" RightMargin="47.0000" TopMargin="3.5000" BottomMargin="3.5000" FontSize="26" LabelText="0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="18.0000" Y="31.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="56.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="240" G="225" B="67" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.1607" Y="0.8158" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="imgIcon" ActionTag="629549487" Tag="343" IconVisible="False" LeftMargin="-13.5000" RightMargin="88.5000" LeftEage="12" RightEage="12" TopEage="12" BottomEage="12" Scale9OriginX="12" Scale9OriginY="12" Scale9Width="13" Scale9Height="14" ctype="ImageViewObjectData">
                        <Size X="37.0000" Y="38.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="5.0000" Y="19.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0446" Y="0.5000" />
                        <PreSize X="0.3304" Y="1.0000" />
                        <FileData Type="Normal" Path="image/play_zjh/ui/icon_chipnum.png" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="231.4949" Y="245.7700" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/play_zjh/bet_multiple_bk.png" Plist="image/play_zjh/play_zjh.plist" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.8246" Y="-360.5206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_readySign" Visible="False" ActionTag="101596540" Tag="166" IconVisible="True" LeftMargin="-638.8246" RightMargin="638.8246" TopMargin="360.5206" BottomMargin="-360.5206" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Spr_readySign_1" ActionTag="-438855024" Tag="167" IconVisible="False" LeftMargin="129.0000" RightMargin="-229.0000" TopMargin="-158.5000" BottomMargin="57.5000" ctype="SpriteObjectData">
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
                    <Position X="179.0000" Y="108.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_2" ActionTag="-484104388" Tag="183" IconVisible="False" LeftMargin="1126.6945" RightMargin="-1226.6945" TopMargin="-377.7390" BottomMargin="276.7390" ctype="SpriteObjectData">
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
                    <Position X="1176.6945" Y="327.2390" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_3" ActionTag="-1537498553" Tag="327" IconVisible="False" LeftMargin="1070.0000" RightMargin="-1170.0000" TopMargin="-593.5000" BottomMargin="492.5000" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_17" ActionTag="-710112833" CallBackType="Click" Tag="866" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.0000" BottomMargin="-23.0000" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
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
                    <Position X="1120.0000" Y="543.0000" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_4" ActionTag="-1342896704" Tag="185" IconVisible="False" LeftMargin="524.1954" RightMargin="-624.1954" TopMargin="-686.8301" BottomMargin="585.8301" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_21" ActionTag="1594021244" Tag="870" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-13.4998" RightMargin="-11.5002" TopMargin="-23.7676" BottomMargin="-22.2324" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="49.0002" Y="51.2676" />
                        <Scale ScaleX="0.8000" ScaleY="0.7600" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.4900" Y="0.5076" />
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
                    <Position X="574.1954" Y="636.3301" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_5" ActionTag="-2076044301" Tag="187" IconVisible="False" LeftMargin="109.9200" RightMargin="-209.9200" TopMargin="-594.5000" BottomMargin="493.5000" ctype="SpriteObjectData">
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
                    <Position X="159.9200" Y="544.0000" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Spr_readySign_6" ActionTag="1759189962" Tag="830" IconVisible="False" LeftMargin="61.4988" RightMargin="-161.4988" TopMargin="-369.2729" BottomMargin="268.2729" ctype="SpriteObjectData">
                    <Size X="100.0000" Y="101.0000" />
                    <Children>
                      <AbstractNodeData Name="Image_29" ActionTag="-1307649121" Tag="878" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-12.5000" RightMargin="-12.5000" TopMargin="-23.9999" BottomMargin="-22.0001" Scale9Width="125" Scale9Height="147" ctype="ImageViewObjectData">
                        <Size X="125.0000" Y="147.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0000" Y="51.4999" />
                        <Scale ScaleX="0.8000" ScaleY="0.6800" />
                        <CColor A="255" R="77" G="77" B="77" />
                        <PrePosition X="0.5000" Y="0.5099" />
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
                    <Position X="111.4988" Y="318.7729" />
                    <Scale ScaleX="0.8000" ScaleY="0.7600" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/ready_box.png" Plist="" />
                    <BlendFunc Src="770" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.8246" Y="-360.5206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_chatBg" Visible="False" ActionTag="86755513" Tag="100" IconVisible="True" LeftMargin="-638.8246" RightMargin="638.8246" TopMargin="360.5206" BottomMargin="-360.5206" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Node_PlayerChatBg_1" ActionTag="372981031" Tag="286" IconVisible="True" LeftMargin="383.0000" RightMargin="-383.0000" TopMargin="-100.0000" BottomMargin="100.0000" ctype="SingleNodeObjectData">
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
                    <Position X="383.0000" Y="100.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_2" ActionTag="1314503765" Tag="287" IconVisible="True" LeftMargin="991.6948" RightMargin="-991.6948" TopMargin="-326.2385" BottomMargin="326.2385" ctype="SingleNodeObjectData">
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
                    <Position X="991.6948" Y="326.2385" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_3" ActionTag="-2028363259" Tag="831" IconVisible="True" LeftMargin="940.0000" RightMargin="-940.0000" TopMargin="-522.0000" BottomMargin="522.0000" ctype="SingleNodeObjectData">
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
                    <Position X="940.0000" Y="522.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_4" ActionTag="923552737" Tag="290" IconVisible="True" LeftMargin="739.7451" RightMargin="-739.7451" TopMargin="-619.5212" BottomMargin="619.5212" ctype="SingleNodeObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <Children>
                      <AbstractNodeData Name="Img_playerChatBg" ActionTag="803629715" Tag="179" IconVisible="False" LeftMargin="-141.5840" RightMargin="-141.5840" TopMargin="-66.0297" BottomMargin="-66.0297" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="38" BottomEage="11" Scale9OriginX="20" Scale9OriginY="38" Scale9Width="22" Scale9Height="5" ctype="ImageViewObjectData">
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
                    <Position X="739.7451" Y="619.5212" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_5" ActionTag="1372580138" Tag="292" IconVisible="True" LeftMargin="341.9205" RightMargin="-341.9205" TopMargin="-522.0000" BottomMargin="522.0000" ctype="SingleNodeObjectData">
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
                    <Position X="341.9205" Y="522.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_PlayerChatBg_6" ActionTag="1964454588" Tag="846" IconVisible="True" LeftMargin="293.4976" RightMargin="-293.4976" TopMargin="-298.7722" BottomMargin="298.7722" ctype="SingleNodeObjectData">
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
                    <Position X="293.4976" Y="298.7722" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_1" ActionTag="1689626635" Tag="186" IconVisible="True" LeftMargin="178.0000" RightMargin="-178.0000" TopMargin="-108.0000" BottomMargin="108.0000" ctype="SingleNodeObjectData">
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
                    <Position X="178.0000" Y="108.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_2" ActionTag="1922246611" Tag="187" IconVisible="True" LeftMargin="1176.6949" RightMargin="-1176.6949" TopMargin="-326.2385" BottomMargin="326.2385" ctype="SingleNodeObjectData">
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
                    <Position X="1176.6949" Y="326.2385" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_3" ActionTag="1508810111" Tag="834" IconVisible="True" LeftMargin="1120.0000" RightMargin="-1120.0000" TopMargin="-542.0000" BottomMargin="542.0000" ctype="SingleNodeObjectData">
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
                    <Position X="1120.0000" Y="542.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_4" ActionTag="-1616968467" Tag="189" IconVisible="True" LeftMargin="530.0000" RightMargin="-530.0000" TopMargin="-668.0000" BottomMargin="668.0000" ctype="SingleNodeObjectData">
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
                    <Position X="530.0000" Y="668.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_5" ActionTag="69323219" Tag="192" IconVisible="True" LeftMargin="159.9200" RightMargin="-159.9200" TopMargin="-542.0000" BottomMargin="542.0000" ctype="SingleNodeObjectData">
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
                    <Position X="159.9200" Y="542.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Node_Emoji_6" ActionTag="-2073172106" Tag="849" IconVisible="True" LeftMargin="136.2525" RightMargin="-136.2525" TopMargin="-278.2902" BottomMargin="278.2902" ctype="SingleNodeObjectData">
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
                    <Position X="136.2525" Y="278.2902" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.8246" Y="-360.5206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_Yuyin_Dlg" ActionTag="1764699135" Tag="99" IconVisible="True" LeftMargin="-638.8246" RightMargin="638.8246" TopMargin="360.5206" BottomMargin="-360.5206" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Image_1" ActionTag="-428410054" Tag="233" RotationSkewX="180.0000" RotationSkewY="180.0000" IconVisible="False" LeftMargin="259.0000" RightMargin="-291.0000" TopMargin="-155.0000" BottomMargin="119.0000" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="275.0000" Y="137.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_2" ActionTag="-250808957" Tag="234" IconVisible="False" LeftMargin="1080.7014" RightMargin="-1112.7014" TopMargin="-374.2387" BottomMargin="338.2387" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1096.7014" Y="356.2387" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_3" ActionTag="-807207636" Tag="310" IconVisible="False" LeftMargin="1021.9996" RightMargin="-1053.9996" TopMargin="-580.0000" BottomMargin="544.0000" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1037.9996" Y="562.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_4" ActionTag="-407487166" Tag="236" RotationSkewX="180.0000" RotationSkewY="180.0000" IconVisible="False" LeftMargin="610.7484" RightMargin="-642.7484" TopMargin="-672.5214" BottomMargin="636.5214" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="626.7484" Y="654.5214" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_5" ActionTag="1408973810" Tag="238" RotationSkewX="180.0000" RotationSkewY="180.0000" IconVisible="False" LeftMargin="223.9197" RightMargin="-255.9197" TopMargin="-576.0000" BottomMargin="540.0000" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="239.9197" Y="558.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Image_6" ActionTag="1357628475" Tag="676" RotationSkewX="180.0000" RotationSkewY="180.0000" IconVisible="False" LeftMargin="175.4943" RightMargin="-207.4943" TopMargin="-356.7720" BottomMargin="320.7720" Scale9Width="32" Scale9Height="36" ctype="ImageViewObjectData">
                    <Size X="32.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="191.4943" Y="338.7720" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="MarkedSubImage" Path="image/Chat/yy_tishi.png" Plist="image/Chat/chat.plist" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-638.8246" Y="-360.5206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_ViewFinalReport" ActionTag="-1685283406" Tag="1632" IconVisible="False" PositionPercentXEnabled="True" VerticalEdge="BottomEdge" LeftMargin="-96.0000" RightMargin="-96.0000" TopMargin="54.5000" BottomMargin="-125.5000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="162" Scale9Height="49" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="192.0000" Y="71.0000" />
                <Children>
                  <AbstractNodeData Name="Label_Text" Visible="False" ActionTag="-1219106763" VisibleForFrame="False" Tag="1633" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="22.0000" RightMargin="22.0000" TopMargin="13.5000" BottomMargin="13.5000" FontSize="36" LabelText="查看战绩" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="148.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="96.0000" Y="35.5000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.7708" Y="0.6197" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-90.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_viewreport.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_ready" ActionTag="-1043617998" Tag="69" IconVisible="False" PositionPercentXEnabled="True" VerticalEdge="BottomEdge" LeftMargin="-113.0000" RightMargin="-113.0000" TopMargin="49.0000" BottomMargin="-131.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="82.0000" />
                <Children>
                  <AbstractNodeData Name="lblReady" Visible="False" ActionTag="-1486974608" VisibleForFrame="False" Tag="70" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="113.0000" RightMargin="113.0000" TopMargin="41.0000" BottomMargin="41.0000" FontSize="48" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="0.0000" Y="0.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="113.0000" Y="41.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-90.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/sitdown.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Start" ActionTag="1963328489" Tag="186" IconVisible="False" PositionPercentXEnabled="True" VerticalEdge="BottomEdge" LeftMargin="-113.0000" RightMargin="-113.0000" TopMargin="49.0000" BottomMargin="-131.0000" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="60" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="82.0000" />
                <Children>
                  <AbstractNodeData Name="lblStart" Visible="False" ActionTag="1926317872" VisibleForFrame="False" Tag="187" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="39.0000" RightMargin="39.0000" TopMargin="19.0000" BottomMargin="19.0000" FontSize="36" LabelText="开始游戏" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="148.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="113.0000" Y="41.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.6549" Y="0.5366" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-90.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_start.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_yuyin" ActionTag="-37081834" Tag="95" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SingleNodeObjectData">
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
          <AbstractNodeData Name="Node_Bottom_Right" ActionTag="972417328" Tag="8329" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="1280.0000" TopMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Btn_Chat" ActionTag="664548959" Tag="57" IconVisible="False" LeftMargin="-81.9111" RightMargin="6.9111" TopMargin="-162.8971" BottomMargin="92.8971" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="55" Scale9Height="62" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-44.4111" Y="127.8971" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_chat.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Voice" ActionTag="-1954168454" Tag="98" IconVisible="False" LeftMargin="-81.9111" RightMargin="6.9111" TopMargin="-75.8969" BottomMargin="5.8969" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="55" Scale9Height="62" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="75.0000" Y="70.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-44.4111" Y="40.8969" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_voice.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_inviteFriend" ActionTag="-1179697185" Tag="174" IconVisible="False" LeftMargin="-317.4118" RightMargin="91.4118" TopMargin="-156.3975" BottomMargin="75.3975" TouchEnable="True" FontSize="22" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="196" Scale9Height="59" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="226.0000" Y="81.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-204.4118" Y="115.8975" />
                <Scale ScaleX="0.7000" ScaleY="0.7000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                <TextColor A="255" R="255" G="255" B="255" />
                <NormalFileData Type="Normal" Path="image/play/btn_invite.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_RubCard" Visible="False" ActionTag="-1489302290" VisibleForFrame="False" Tag="428" IconVisible="False" VerticalEdge="BottomEdge" LeftMargin="-279.6877" RightMargin="109.6877" TopMargin="-81.8274" BottomMargin="2.8274" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="230" Scale9Height="57" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="170.0000" Y="79.0000" />
                <Children>
                  <AbstractNodeData Name="lblRubCard" ActionTag="1150819182" Tag="429" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="37.5000" RightMargin="37.5000" TopMargin="17.5000" BottomMargin="17.5000" FontSize="36" LabelText="搓  牌" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="95.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="85.0000" Y="39.5000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5588" Y="0.5570" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="26" G="26" B="26" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-194.6877" Y="42.3274" />
                <Scale ScaleX="0.9500" ScaleY="0.9500" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play/btn_common.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_GuanZhan" ActionTag="1550821891" VisibleForFrame="False" Tag="695" IconVisible="False" LeftMargin="-278.9095" RightMargin="99.9095" TopMargin="-79.3969" BottomMargin="6.3969" Scale9Width="179" Scale9Height="73" ctype="ImageViewObjectData">
                <Size X="179.0000" Y="73.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-189.4095" Y="42.8969" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="image/play/guanzhan.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="1280.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="1.0000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Node_Bottom_Center" ActionTag="-782948939" Tag="8690" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="720.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="Node_Operates" ActionTag="102200303" Tag="3068" IconVisible="True" LeftMargin="-639.5713" RightMargin="639.5713" TopMargin="-1.2643" BottomMargin="1.2643" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="ListView_Btn_Raise" ActionTag="907576355" Tag="2754" IconVisible="False" LeftMargin="955.6404" RightMargin="-1045.6404" TopMargin="-438.2789" BottomMargin="88.2789" TouchEnable="True" ClipAble="False" BackColorAlpha="51" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ScrollDirectionType="0" ItemMargin="20" DirectionType="Vertical" HorizontalType="Align_HorizontalCenter" ctype="ListViewObjectData">
                    <Size X="90.0000" Y="350.0000" />
                    <Children>
                      <AbstractNodeData Name="Button_1" ActionTag="-1791344766" Tag="2755" IconVisible="False" LeftMargin="6.0000" RightMargin="6.0000" BottomMargin="270.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="48" Scale9Height="58" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="78.0000" Y="80.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_BM_Title" ActionTag="368917790" Tag="2783" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="9.5000" RightMargin="9.5000" TopMargin="20.8000" BottomMargin="27.2000" LabelText="10" ctype="TextBMFontObjectData">
                            <Size X="59.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="39.0000" Y="43.2000" />
                            <Scale ScaleX="0.8000" ScaleY="0.8000" />
                            <CColor A="255" R="217" G="60" B="48" />
                            <PrePosition X="0.5000" Y="0.5400" />
                            <PreSize X="0.7564" Y="0.4000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="45.0000" Y="310.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.8857" />
                        <PreSize X="0.8667" Y="0.2286" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <DisabledFileData Type="Normal" Path="image/play_zjh/ui/iconGold3Dark.png" Plist="" />
                        <PressedFileData Type="Normal" Path="image/play_zjh/ui/iconGold3.png" Plist="" />
                        <NormalFileData Type="Normal" Path="image/play_zjh/ui/iconGold3.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Button_2" ActionTag="-1564536903" ZOrder="1" Tag="2756" IconVisible="False" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="100.0000" BottomMargin="170.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="48" Scale9Height="58" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="78.0000" Y="80.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_BM_Title" ActionTag="-1624173758" CallBackType="Click" Tag="2784" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="24.0000" RightMargin="24.0000" TopMargin="20.8000" BottomMargin="27.2000" LabelText="5" ctype="TextBMFontObjectData">
                            <Size X="30.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="39.0000" Y="43.2000" />
                            <Scale ScaleX="0.8000" ScaleY="0.8000" />
                            <CColor A="255" R="131" G="78" B="226" />
                            <PrePosition X="0.5000" Y="0.5400" />
                            <PreSize X="0.3846" Y="0.4000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="45.0000" Y="210.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.6000" />
                        <PreSize X="0.8667" Y="0.2286" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <DisabledFileData Type="Normal" Path="image/play_zjh/ui/iconGold2Dark.png" Plist="" />
                        <PressedFileData Type="Normal" Path="image/play_zjh/ui/iconGold2.png" Plist="" />
                        <NormalFileData Type="Normal" Path="image/play_zjh/ui/iconGold2.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Button_3" ActionTag="-1105873417" ZOrder="2" Tag="2757" IconVisible="False" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="200.0000" BottomMargin="70.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="48" Scale9Height="58" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                        <Size X="78.0000" Y="80.0000" />
                        <Children>
                          <AbstractNodeData Name="Text_BM_Title" ActionTag="530752275" Tag="2785" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="24.0000" RightMargin="24.0000" TopMargin="20.8000" BottomMargin="27.2000" LabelText="2" ctype="TextBMFontObjectData">
                            <Size X="30.0000" Y="32.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="39.0000" Y="43.2000" />
                            <Scale ScaleX="0.8000" ScaleY="0.8000" />
                            <CColor A="255" R="172" G="120" B="29" />
                            <PrePosition X="0.5000" Y="0.5400" />
                            <PreSize X="0.3846" Y="0.4000" />
                            <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="45.0000" Y="110.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.3143" />
                        <PreSize X="0.8667" Y="0.2286" />
                        <TextColor A="255" R="65" G="65" B="70" />
                        <DisabledFileData Type="Normal" Path="image/play_zjh/ui/iconGold1Dark.png" Plist="" />
                        <PressedFileData Type="Normal" Path="image/play_zjh/ui/iconGold1.png" Plist="" />
                        <NormalFileData Type="Normal" Path="image/play_zjh/ui/iconGold1.png" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" />
                    <Position X="1000.6404" Y="88.2789" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <SingleColor A="255" R="0" G="0" B="0" />
                    <FirstColor A="255" R="150" G="150" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_GiveUp" ActionTag="-417501666" Tag="2748" IconVisible="False" LeftMargin="636.8208" RightMargin="-733.8208" TopMargin="-149.7272" BottomMargin="27.7272" TouchEnable="True" FontSize="50" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="67" Scale9Height="100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="97.0000" Y="122.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_BM_Title" ActionTag="-2068019923" Tag="2779" IconVisible="False" LeftMargin="34.1630" RightMargin="32.8370" TopMargin="25.1118" BottomMargin="64.8882" LabelText="x" ctype="TextBMFontObjectData">
                        <Size X="30.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="49.1630" Y="80.8882" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5068" Y="0.6630" />
                        <PreSize X="0.3093" Y="0.2623" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="685.3208" Y="88.7272" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="255" G="255" B="255" />
                    <NormalFileData Type="MarkedSubImage" Path="image/play_zjh/btn_give_up.png" Plist="image/play_zjh/play_zjh.plist" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Compare" ActionTag="1517255685" Tag="2749" IconVisible="False" LeftMargin="742.0763" RightMargin="-839.0763" TopMargin="-149.1721" BottomMargin="27.1721" TouchEnable="True" FontSize="50" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="67" Scale9Height="100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="97.0000" Y="122.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_BM_Title" ActionTag="-437097884" Tag="2776" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="33.5000" RightMargin="33.5000" TopMargin="30.1404" BottomMargin="59.8596" LabelText="2" ctype="TextBMFontObjectData">
                        <Size X="30.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.5000" Y="75.8596" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.6218" />
                        <PreSize X="0.3093" Y="0.2623" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="790.5763" Y="88.1721" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="255" G="255" B="255" />
                    <NormalFileData Type="MarkedSubImage" Path="image/play_zjh/btn_compare.png" Plist="image/play_zjh/play_zjh.plist" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Bet" ActionTag="1812047910" CallBackType="Touch" Tag="2752" IconVisible="False" LeftMargin="846.8756" RightMargin="-943.8756" TopMargin="-148.8647" BottomMargin="26.8647" TouchEnable="True" FontSize="50" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="67" Scale9Height="100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="97.0000" Y="122.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_BM_Title" ActionTag="-1358018297" Tag="2781" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="19.0000" RightMargin="19.0000" TopMargin="29.1099" BottomMargin="60.8901" LabelText="44" ctype="TextBMFontObjectData">
                        <Size X="59.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.5000" Y="76.8901" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.6302" />
                        <PreSize X="0.6082" Y="0.2623" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="895.3756" Y="87.8647" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="255" G="255" B="255" />
                    <NormalFileData Type="MarkedSubImage" Path="image/play_zjh/btn_bet_chips.png" Plist="image/play_zjh/play_zjh.plist" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_RaiseBet" ActionTag="147407737" Tag="2753" IconVisible="False" LeftMargin="951.5000" RightMargin="-1048.5000" TopMargin="-148.9406" BottomMargin="26.9406" TouchEnable="True" FontSize="50" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="67" Scale9Height="100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="97.0000" Y="122.0000" />
                    <Children>
                      <AbstractNodeData Name="Text_BM_Title" ActionTag="-1783326973" Tag="2782" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="35.0617" RightMargin="31.9383" TopMargin="12.5428" BottomMargin="77.4572" LabelText="+" ctype="TextBMFontObjectData">
                        <Size X="30.0000" Y="32.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="50.0617" Y="93.4572" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5161" Y="0.7660" />
                        <PreSize X="0.3093" Y="0.2623" />
                        <LabelBMFontFile_CNB Type="Normal" Path="font/YSZ_Bet.fnt" Plist="" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="1000.0000" Y="87.9406" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="255" G="255" B="255" />
                    <NormalFileData Type="MarkedSubImage" Path="image/play_zjh/btn_raise_bet.png" Plist="image/play_zjh/play_zjh.plist" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="-639.5713" Y="1.2643" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_Show_Card" ActionTag="2112700817" Tag="2773" IconVisible="False" LeftMargin="-275.5753" RightMargin="133.5753" TopMargin="-83.7633" BottomMargin="32.7633" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="112" Scale9Height="29" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="142.0000" Y="51.0000" />
                <Children>
                  <AbstractNodeData Name="Text_Title" ActionTag="1701387458" Tag="2775" IconVisible="False" LeftMargin="12.1293" RightMargin="13.8707" TopMargin="4.7345" BottomMargin="11.2655" FontSize="28" LabelText="点击亮牌" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="116.0000" Y="35.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="70.1293" Y="28.7655" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4939" Y="0.5640" />
                    <PreSize X="0.8169" Y="0.6863" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="0" G="128" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-204.5753" Y="58.2633" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="MarkedSubImage" Path="image/play_zjh/btn_view_card.png" Plist="image/play_zjh/play_zjh.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="Btn_View_Card" ActionTag="1041144241" Tag="2772" IconVisible="False" LeftMargin="-280.0720" RightMargin="129.0720" TopMargin="-83.7633" BottomMargin="32.7633" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="121" Scale9Height="29" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="151.0000" Y="51.0000" />
                <Children>
                  <AbstractNodeData Name="Text_Title" ActionTag="-525428842" VisibleForFrame="False" Tag="2778" IconVisible="False" LeftMargin="12.1294" RightMargin="22.8706" TopMargin="5.7346" BottomMargin="10.2654" FontSize="28" LabelText="点击看牌" OutlineEnabled="True" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="116.0000" Y="35.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="70.1294" Y="27.7654" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4644" Y="0.5444" />
                    <PreSize X="0.7682" Y="0.6863" />
                    <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                    <OutlineColor A="255" R="0" G="128" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-204.5720" Y="58.2633" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <NormalFileData Type="Normal" Path="image/play_zjh/ui/btnViewCard.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="640.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_CmpCards" ActionTag="467918799" VisibleForFrame="False" Tag="377" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" PercentWidthEnable="True" PercentHeightEnable="True" PercentWidthEnabled="True" PercentHeightEnabled="True" TouchEnable="True" ClipAble="False" BackColorAlpha="153" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="1280.0000" Y="720.0000" />
            <Children>
              <AbstractNodeData Name="Node_Center" ActionTag="-1807723090" Tag="8691" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="Btn_Cmp_Rect_2" ActionTag="1617682615" Tag="1050" IconVisible="False" LeftMargin="337.6993" RightMargin="-577.6993" TopMargin="-23.2211" BottomMargin="-96.7789" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="13" RightEage="13" TopEage="4" BottomEage="4" Scale9OriginX="13" Scale9OriginY="4" Scale9Width="251" Scale9Height="144" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="240.0000" Y="120.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="457.6993" Y="-36.7789" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                    <NormalFileData Type="Normal" Path="image/play_zjh/ui/imgBgCmp.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Cmp_Rect_3" ActionTag="548318673" Tag="1051" IconVisible="False" LeftMargin="282.9176" RightMargin="-522.9176" TopMargin="-233.7838" BottomMargin="113.7838" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="13" RightEage="13" TopEage="4" BottomEage="4" Scale9OriginX="13" Scale9OriginY="4" Scale9Width="251" Scale9Height="144" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="240.0000" Y="120.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="402.9176" Y="173.7838" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                    <NormalFileData Type="Normal" Path="image/play_zjh/ui/imgBgCmp.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Cmp_Rect_4" ActionTag="-2030273725" Tag="1052" IconVisible="False" LeftMargin="-108.8394" RightMargin="-131.1606" TopMargin="-329.3366" BottomMargin="209.3366" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="13" RightEage="13" TopEage="4" BottomEage="4" Scale9OriginX="13" Scale9OriginY="4" Scale9Width="251" Scale9Height="144" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="240.0000" Y="120.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="11.1606" Y="269.3366" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                    <NormalFileData Type="Normal" Path="image/play_zjh/ui/imgBgCmp.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Cmp_Rect_5" ActionTag="1750321110" Tag="1053" IconVisible="False" LeftMargin="-522.1288" RightMargin="282.1288" TopMargin="-234.0321" BottomMargin="114.0321" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="13" RightEage="13" TopEage="4" BottomEage="4" Scale9OriginX="13" Scale9OriginY="4" Scale9Width="251" Scale9Height="144" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="240.0000" Y="120.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="-402.1288" Y="174.0321" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                    <NormalFileData Type="Normal" Path="image/play_zjh/ui/imgBgCmp.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Btn_Cmp_Rect_6" ActionTag="-691296357" Tag="1049" IconVisible="False" LeftMargin="-572.2644" RightMargin="332.2644" TopMargin="-12.8460" BottomMargin="-107.1540" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="13" RightEage="13" TopEage="4" BottomEage="4" Scale9OriginX="13" Scale9OriginY="4" Scale9Width="251" Scale9Height="144" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="240.0000" Y="120.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="-452.2644" Y="-47.1540" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                    <NormalFileData Type="Normal" Path="image/play_zjh/ui/imgBgCmp.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lblCmpPlayerTips" ActionTag="1272864783" Tag="1294" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-140.5000" RightMargin="-140.5000" TopMargin="-24.5000" BottomMargin="-24.5000" FontSize="40" LabelText="请选择比牌玩家" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="281.0000" Y="49.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="251" G="233" B="12" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FontResource Type="Normal" Path="font/label.ttf" Plist="" />
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
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_Cmp_Eff" ActionTag="-312831087" VisibleForFrame="False" Tag="239" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" PercentWidthEnable="True" PercentHeightEnable="True" PercentWidthEnabled="True" PercentHeightEnabled="True" TouchEnable="True" ClipAble="False" BackColorAlpha="220" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="1280.0000" Y="720.0000" />
            <Children>
              <AbstractNodeData Name="FileNode_Animate" ActionTag="-1273324424" Tag="1996" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" StretchWidthEnable="False" StretchHeightEnable="False" InnerActionSpeed="0.5000" CustomSizeEnabled="False" ctype="ProjectNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <AnchorPoint />
                <Position X="640.0000" Y="360.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="csd/texiao/zjhBattle.csd" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_Player_Left" ActionTag="-289591255" Tag="241" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="192.0000" RightMargin="1088.0000" TopMargin="324.0000" BottomMargin="396.0000" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="head_bg" ActionTag="211996145" Tag="242" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
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
                  <AbstractNodeData Name="Panel_HeadFrame" ActionTag="741600308" Tag="243" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="96.0000" Y="96.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_HeadFrame" ActionTag="2126480270" Tag="244" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="106.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.0000" Y="48.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.1042" Y="1.1042" />
                        <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_Head" ActionTag="-2111260415" Tag="245" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.0000" Y="48.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.0000" Y="1.0000" />
                        <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                  <AbstractNodeData Name="Img_NickBg" ActionTag="-1030990716" Tag="246" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="58.0000" BottomMargin="-86.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                    <Size X="94.0000" Y="28.0000" />
                    <Children>
                      <AbstractNodeData Name="Label_Nick" ActionTag="1803187814" Tag="247" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="82.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="47.0000" Y="14.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.8723" Y="0.8571" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position Y="-72.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Panel_Clip_Cards" ActionTag="-1933265534" Tag="279" IconVisible="False" LeftMargin="53.8024" RightMargin="-223.8024" TopMargin="-55.9784" BottomMargin="-144.0216" TouchEnable="True" ClipAble="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="170.0000" Y="200.0000" />
                    <Children>
                      <AbstractNodeData Name="Node_Cards" ActionTag="364643579" Tag="259" IconVisible="True" LeftMargin="99.3499" RightMargin="70.6501" TopMargin="67.4967" BottomMargin="132.5033" ctype="SingleNodeObjectData">
                        <Size X="0.0000" Y="0.0000" />
                        <Children>
                          <AbstractNodeData Name="imgCrad1" ActionTag="1406416939" Tag="260" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="-50.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="imgCrad2" ActionTag="-849443100" Tag="261" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-18.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="-15.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="imgCrad3" ActionTag="-1552191893" Tag="262" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-13.0000" RightMargin="-53.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="20.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint />
                        <Position X="99.3499" Y="132.5033" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5844" Y="0.6625" />
                        <PreSize X="0.0000" Y="0.0000" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="53.8024" Y="-144.0216" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="192.0000" Y="396.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1500" Y="0.5500" />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_Player_Right" ActionTag="-2063352544" Tag="265" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="1088.0000" RightMargin="192.0000" TopMargin="324.0000" BottomMargin="396.0000" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <Children>
                  <AbstractNodeData Name="head_bg" ActionTag="-1021207122" Tag="266" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-62.5000" RightMargin="-62.5000" TopMargin="-55.5000" BottomMargin="-91.5000" ctype="SpriteObjectData">
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
                  <AbstractNodeData Name="Panel_HeadFrame" ActionTag="-647494326" Tag="267" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-48.0000" TopMargin="-48.0000" BottomMargin="-48.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="96.0000" Y="96.0000" />
                    <Children>
                      <AbstractNodeData Name="Spr_HeadFrame" ActionTag="2142101315" Tag="268" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-5.0000" RightMargin="-5.0000" TopMargin="-5.0000" BottomMargin="-5.0000" Scale9Enable="True" LeftEage="20" RightEage="20" TopEage="20" BottomEage="20" Scale9OriginX="20" Scale9OriginY="20" Scale9Width="60" Scale9Height="60" ctype="ImageViewObjectData">
                        <Size X="106.0000" Y="106.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.0000" Y="48.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.1042" Y="1.1042" />
                        <FileData Type="Normal" Path="image/play/head_frame.png" Plist="" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Spr_Head" ActionTag="1676624556" Tag="269" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
                        <Size X="96.0000" Y="96.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="48.0000" Y="48.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="1.0000" Y="1.0000" />
                        <FileData Type="Normal" Path="image/common/img_head.png" Plist="" />
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
                  <AbstractNodeData Name="Img_NickBg" ActionTag="985443233" Tag="270" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="-47.0000" RightMargin="-47.0000" TopMargin="57.0000" BottomMargin="-85.0000" Scale9Enable="True" LeftEage="26" RightEage="26" TopEage="7" BottomEage="7" Scale9OriginX="26" Scale9OriginY="7" Scale9Width="29" Scale9Height="9" ctype="ImageViewObjectData">
                    <Size X="94.0000" Y="28.0000" />
                    <Children>
                      <AbstractNodeData Name="Label_Nick" ActionTag="101725710" Tag="271" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="6.0000" RightMargin="6.0000" TopMargin="2.0000" BottomMargin="2.0000" FontSize="20" LabelText="名字四字" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                        <Size X="82.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="47.0000" Y="14.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5000" />
                        <PreSize X="0.8723" Y="0.8571" />
                        <FontResource Type="Normal" Path="font/main.ttf" Plist="" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="110" G="110" B="110" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position Y="-71.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <FileData Type="Normal" Path="image/play/name_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="Panel_Clip_Cards" Visible="False" ActionTag="1249326698" Tag="280" IconVisible="False" LeftMargin="-221.2000" RightMargin="51.2000" TopMargin="-57.9800" BottomMargin="-142.0200" TouchEnable="True" ClipAble="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="170.0000" Y="200.0000" />
                    <Children>
                      <AbstractNodeData Name="Node_Cards" ActionTag="1221885161" Tag="281" IconVisible="True" LeftMargin="99.3502" RightMargin="70.6498" TopMargin="67.6500" BottomMargin="132.3500" ctype="SingleNodeObjectData">
                        <Size X="0.0000" Y="0.0000" />
                        <Children>
                          <AbstractNodeData Name="imgCrad1" ActionTag="-346703149" Tag="282" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-83.0000" RightMargin="17.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="-50.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="imgCrad2" ActionTag="-298187540" Tag="283" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-48.0000" RightMargin="-18.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="-15.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                          <AbstractNodeData Name="imgCrad3" ActionTag="-573949305" Tag="284" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-13.0000" RightMargin="-53.0000" TopMargin="-46.5000" BottomMargin="-46.5000" Scale9Width="150" Scale9Height="197" ctype="ImageViewObjectData">
                            <Size X="66.0000" Y="93.0000" />
                            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                            <Position X="20.0000" />
                            <Scale ScaleX="1.5000" ScaleY="1.5000" />
                            <CColor A="255" R="255" G="255" B="255" />
                            <PrePosition />
                            <PreSize X="0.0000" Y="0.0000" />
                            <FileData Type="MarkedSubImage" Path="image/card/back.png" Plist="image/card/card.plist" />
                          </AbstractNodeData>
                        </Children>
                        <AnchorPoint />
                        <Position X="99.3502" Y="132.3500" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5844" Y="0.6618" />
                        <PreSize X="0.0000" Y="0.0000" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint />
                    <Position X="-221.2000" Y="-142.0200" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="0.0000" Y="0.0000" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="1088.0000" Y="396.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8500" Y="0.5500" />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="Node_VS_Pos" ActionTag="-1611380717" VisibleForFrame="False" Tag="240" IconVisible="True" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="640.0000" RightMargin="640.0000" TopMargin="360.0000" BottomMargin="360.0000" ctype="SingleNodeObjectData">
                <Size X="0.0000" Y="0.0000" />
                <AnchorPoint />
                <Position X="640.0000" Y="360.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="0.0000" Y="0.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="imgWin" ActionTag="1063570984" Tag="1793" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="471.0000" RightMargin="471.0000" TopMargin="276.5000" BottomMargin="276.5000" LeftEage="111" RightEage="111" TopEage="55" BottomEage="55" Scale9OriginX="111" Scale9OriginY="55" Scale9Width="116" Scale9Height="57" ctype="ImageViewObjectData">
                <Size X="338.0000" Y="167.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="640.0000" Y="360.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="0.2641" Y="0.2319" />
                <FileData Type="MarkedSubImage" Path="image/play_zjh/zjhWin.png" Plist="image/play_zjh/play_zjh.plist" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="0" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>