
import * as React from 'react';
import { View, Text, Button, SafeAreaView } from 'react-native';
import RootNav from './RootNav';
import { NavigationContainer } from '@react-navigation/native';
import RootNavStack from '../../src_new/RootNavi';

class JSHome extends React.Component {
    render() {
        return (<NavigationContainer>
            <RootNavStack />
        </NavigationContainer>)
    }
}

export default JSHome;