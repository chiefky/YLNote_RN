import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Image } from 'react-native';
import Swiper from '@nart/react-native-swiper'
import FilmList from './FilmList';
import { screenWidth } from "../utils/stylesKit";
import ScrollerTabView from './../components/ScrollerTabView';
class NewsScreen extends React.Component {
    tabArr = [
        { columnName: '头条', requestCode: 'T1348647909107' },
        { columnName: '娱乐', requestCode: 'T1348648517839' },
        { columnName: '科技', requestCode: 'T1348649580692' },
        { columnName: '手机', requestCode: 'T1348649654285' },
        { columnName: '电影', requestCode: 'T1348649654280' },

    ];
    swiperData = [
        '华为不看好5G',
        '陶渊明后人做主播',
        '尔康制药遭处罚',
        '卢恩光行贿一案受审',
        '盖茨力挺扎克伯格',
        '大连特大刑事案件',
        '高校迷香盗窃案',
        '少年被批评后溺亡',
        '北京工商约谈抖音'
    ];
    render() {
        return (
            <View style={styles.container}>
                {/* 头部 */}
                <View style={styles.headerContainer}>

                    <TouchableOpacity activeOpacity={1} onPress={() => { alert('Hello Logo!') }}>
                        <Image source={require("./../../assets/images/logo.png")} resizeMode={'contain'} style={styles.headerLogo} />
                    </TouchableOpacity>

                    <View style={styles.headerSearchContainer}>
                        <Swiper
                            horizontal={false}
                            autoplay={true}
                            showsPagination={false}
                            scrollEnabled={false}
                            autoplayTimeout={5}
                        >
                            {
                                this.swiperData.map((item, index) => {
                                    return (

                                        <TouchableOpacity activeOpacity={1} key={index} style={styles.swipeItem} onPress={() => this.props.navigation.push('NewsSearch', { keyword: item })}>
                                            <Image source={require("./../../assets/images/i_search.png")} resizeMode={'contain'} style={styles.headerSearchImage} />
                                            <Text style={styles.headerSearchText}>{item}</Text>
                                        </TouchableOpacity>
                                    )
                                })
                            }
                        </Swiper>
                    </View>

                    <TouchableOpacity activeOpacity={1} onPress={() => { alert('24h') }}>
                        <Image source={require("./../../assets/images/i_24h.png")} resizeMode={'contain'} style={styles.headerRightImage} />
                    </TouchableOpacity>

                </View>

                {/*栏目条*/}
                <View style={styles.container}>
                    <ScrollerTabView >
                        {this.tabArr.map((item) => {
                            return <FilmList
                                key={item.columnName}
                                tabLabel={item.columnName}
                                requestCode={item.requestCode}
                                navigation={this.props.navigation}
                            />
                        })}

                    </ScrollerTabView>

                    {/* 
                    <View style={styles.columnSelect}>
                        <Image source={require("./../../assets/images/i_menu.png")} style={{ width: 20, height: 20 }} />
                    </View> */}
                </View>

            </View >
        )
    }
}

export default NewsScreen;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#FFFAF0',
        position: 'relative',
    },
    headerContainer: {
        flexDirection: 'row',
        backgroundColor: '#B22222',
        justifyContent: 'space-around',
        alignItems: 'center',
        height: 65,
        // paddingTop: 10,
        // paddingBottom: 5
    },
    headerLogo: {
        width: 45,
        height: 45,
    },
    headerSearchContainer: {
        width: screenWidth * 0.7,
        height: 33,
        borderRadius: 18,
        backgroundColor: 'rgba(255,255,255,.3)'
    },
    swipeItem: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center'
    },
    headerSearchImage: {
        width: 17,
        height: 17,
        marginRight: 5
    },
    headerSearchText: {
        color: '#F8F8F8',
    },
    headerRightImage: {
        width: 27,
        height: 27,
    },
    tabViewItemContainer: {
        flex: 1,
        backgroundColor: '#FFCCCC',
        justifyContent: 'center',
        alignItems: 'center'
    },
    columnSelect: {
        backgroundColor: '#B22222',
        justifyContent: 'center',
        alignItems: 'center',
        position: 'absolute',
        width: screenWidth * .1,
        height: 50,
        top: 0,
        right: 0,
    }
})
