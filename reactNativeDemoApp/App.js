import React, {Component} from 'react';
import {NativeModules, NativeEventEmitter, Button, View} from 'react-native';

import {MetaMapRNSdk} from 'react-native-metamap-sdk';

export default class App extends Component {
  constructor() {
    super();
    console.log('Constructor Called.');
  }

  componentDidMount() {
    //set listening callbacks
    const MetaMapVerifyResult = new NativeEventEmitter(
      NativeModules.MetaMapRNSdk,
    );
    MetaMapVerifyResult.addListener('verificationSuccess', data =>
      console.log(data),
    );
    MetaMapVerifyResult.addListener('verificationCanceled', data =>
      console.log(data),
    );
  }

  //call showFlow when button is clicked
  handleMetaMapClickButton = () => {
    //set 3 params clientId (cant be null), flowId, metadata
    var yourMetadata = {param1: 'value1', param2: 'value2'};

    MetaMapRNSdk.showFlow('YOUR_CLIENT_ID', 'YOUR_FLOW_ID', yourMetadata);
  };

  //Add button to view graph
  render() {
    return (
      <View
        style={{
          flex: 1,
          justifyContent: 'center',
          alignItems: 'center',
          backgroundColor: 'powderblue',
        }}>
        <Button onPress={this.handleMetaMapClickButton} title="Click here" />
      </View>
    );
  }
}
