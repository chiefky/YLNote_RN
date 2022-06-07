import React, { createRef } from 'react';
import { StyleSheet, View, Text, SafeAreaView, ScrollView, StatusBar, TouchableOpacity } from 'react-native';
import { screenWidth, screenHeight, pxToDp } from './../utils/stylesKit';

class HeaderView extends React.Component {
    state = {
        selTab: 0,
    }

    render() {
        const { tabBarUnderlineStyle, tabItems, tabClickHanldler } = this.props
        const { selTab } = this.state;
        return (<View style={{ justifyContent: 'flex-end' }}>
            <View style={styles.tabsContainer}            >
                {tabItems.map((item, index) => {
                    // console.log("🍇", item);
                    const { tabLabel } = item.props
                    return (<TouchableOpacity
                        key={index}
                        onPress={() => {
                            // console.log("当前点击：", item, index)
                            this.setState({ selTab: index })
                            tabClickHanldler(index)
                        }} >
                        <Text style={{ ...styles.tabText, width: pxToDp(screenWidth / tabItems.length) }}>{tabLabel} </Text>
                    </TouchableOpacity>);
                })}
            </View>
            <View style={[styles.underlineDefault, {
                width: pxToDp(screenWidth / tabItems.length - 40),
                marginLeft: pxToDp(selTab * (screenWidth / tabItems.length) + 20),
            }]}>
            </View>
        </View>);
    }
}

class ScrollerTabView extends React.Component {
    state = {
        pageNum: 0,
    }

    underLineScrolltoPage = (pageNum) => {
        const { headerView } = this
        headerView.setState({ selTab: pageNum });
    }

    scrollToPage = (pageNum) => {
        const { scrollView } = this
        this.setState({ pageNum: pageNum });
        scrollView.scrollTo({ x: screenWidth * pageNum, y: 0, animated: true })
    }
    render() {
        const { children, tabBarUnderlineStyle } = this.props;
        const { pageNum } = this.state;

        return (<View style={{ flex: 1 }}>
            {/* 标签栏 */}
            <View style={styles.topContainer}>
                <ScrollView style={{ flex: 1 }}
                    horizontal={true}
                // showsHorizontalScrollIndicator={false}
                >
                    <HeaderView ref={(currentNode) => { this.headerView = currentNode }} tabItems={children} tabBarUnderlineStyle={tabBarUnderlineStyle} pageNum={pageNum}
                        tabClickHanldler={(selTab) => {
                            this.scrollToPage(selTab)
                        }}
                    ></HeaderView>
                </ScrollView>
            </View>

            {/* 内容区 */}
            <View style={styles.mainContainer}>
                <ScrollView
                    ref={(currentNode) => { this.scrollView = currentNode }}
                    style={{ flex: 1 }}
                    pagingEnabled={true}
                    horizontal={true}
                    onMomentumScrollEnd={({ nativeEvent }) => {
                        let currentPage = Math.floor(nativeEvent.contentOffset.x / screenWidth);
                        this.setState({ pageNum: currentPage, })
                        this.underLineScrolltoPage(currentPage);

                    }}
                >
                    {children.map((item) => {
                        return (<View key={item.props.tabLabel} style={styles.mainItem}>{item}</View>);
                    })}
                </ScrollView>
            </View>
        </View >
        );
    }
}


// 样式
var styles = StyleSheet.create({
    container: {
        flex: 1,
        position: 'relative',
    },
    topContainer: {
        // backgroundColor: 'green',
        width: screenWidth,
        height: 45,
    },
    tabsContainer: {
        height: 40,
        flexDirection: 'row',
        justifyContent: 'space-around',
        width: screenWidth,
        borderBottomWidth: 0,
        backgroundColor: 'white',
        paddingTop: 10,
        paddingBottom: 10
    },
    tabText: {
        color: '#B22222',
        textAlign: 'center',
        fontWeight: 'bold',
        fontSize: 17,
        marginLeft: 1
    },
    underlineDefault: {
        backgroundColor: '#B22222',
        height: 4,
    },

    mainContainer: {
        flex: 1,
    },

    mainItem: {
        // 尺寸
        width: screenWidth,
        height: '100%'
    },
});



export default ScrollerTabView;