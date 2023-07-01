// import React from 'react';
import { AppRegistry } from 'react-native';

import DetailsScreen from './src/pages/Details';
import RootStackScreen from './src/route/RootStack';
import Home from './src/pages/Home';
import App from './App';
import InteractionScreen from './src/pages/Interaction';
import SignUpScreen from './src/pages/SignUp';
import SignInScreen from './src/pages/SignIn';
// Module name
AppRegistry.registerComponent('SignIn', () => SignInScreen);
AppRegistry.registerComponent('SignUp', () => SignUpScreen);
AppRegistry.registerComponent('Detail', () => DetailsScreen);
AppRegistry.registerComponent('Interaction', () => InteractionScreen);
AppRegistry.registerComponent('RootScreen', () => Home);
