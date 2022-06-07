// import React from 'react';
import { AppRegistry } from 'react-native';

import RNHighScores from './src/pages/RNHighScores';
import JSHome from './src/pages/JSHome';
import InteractionScreen from './src/pages/Interaction';
import DetailsScreen from './src/pages/Details';
// Module name
AppRegistry.registerComponent('RNHighScores', () => RNHighScores);
AppRegistry.registerComponent('Home', () => JSHome);
AppRegistry.registerComponent('Detail', () => DetailsScreen);
AppRegistry.registerComponent('Interaction', () => InteractionScreen);

