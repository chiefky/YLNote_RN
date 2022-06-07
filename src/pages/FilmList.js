import React, { Component } from "react";
import { View, Text, StyleSheet, RefreshControl, Image, TouchableOpacity, SafeAreaView } from "react-native";
import { RecyclerListView, DataProvider, LayoutProvider } from "recyclerlistview";
import { screenWidth, pxToDp } from "../utils/stylesKit";

const ViewTypes = {
    FULL: 0,
    HALF_LEFT: 1,
    HALF_RIGHT: 2
};
const styles = StyleSheet.create({
    container: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
        flex: 1,
        backgroundColor: "#ffffff",
        borderWidth: 1,
        borderColor: "#dddddd",
        marginBottom: pxToDp(10),
        paddingLeft: pxToDp(15),
        paddingRight: pxToDp(15)
    },
    containerLeft: {
        // backgroundColor: "blue",
        width: pxToDp(screenWidth - 140 - 30 - 5),
        paddingRight: pxToDp(5),
        position: 'relative'
    },
    containerRight: {
        width: pxToDp(140),
        height: pxToDp(140),
        padding: pxToDp(5),
        backgroundColor: "#B8860B",
    },
    cellTitle: {
        color: "#000",
        fontSize: pxToDp(17),
        fontWeight: "700",
    },
    cellSubtitle: {
        fontSize: pxToDp(17),
        marginTop: pxToDp(5)
    },
    cellContext: {
        color: "#999",
        fontSize: pxToDp(15),
        lineHeight: pxToDp(18),
        marginTop: pxToDp(5)
    },

    // containerRightText: {
    //     fontSize: 14,
    //     color: "#666"
    // }
});

class CellContainer extends Component {
    filmId = ''
    title = ''
    render() {
        const { id, title, cellSubtitle, original_title, description, image } = this.props
        this.filmId = id;
        this.title = original_title
        return (<TouchableOpacity style={{ flex: 1 }}
            onPress={this.clickHandler}>
            <View style={styles.container}>
                <View style={styles.containerLeft}>
                    {/* 原始标题 */}
                    <Text numberOfLines={1} style={styles.cellTitle}>
                        {original_title}
                    </Text>
                    <Text style={styles.cellSubtitle}>
                        {/* 标题 */}
                        {title}
                    </Text>
                    <Text numberOfLines={5} style={styles.cellContext}>
                        {/* 简介 */}
                        {description}
                    </Text>
                </View>
                <View style={styles.containerRight}>
                    {/* 封面 */}
                    <Image
                        style={{ width: "100%", height: "100%" }}
                        source={{ uri: image }}
                        resizeMode={"center"}
                    />
                </View>
            </View>
        </TouchableOpacity>)
    }

    clickHandler = () => {
        let str = this.filmId.trim();
        if (str.length != 0) {
            this.props.navigation.navigate('Details', {
                name: this.title,
                filmId: this.filmId,
            });
        } else {
            alert('出错了')
        }
    }
}

class FilmList extends Component {
    constructor(props) {
        super(props);
        let dataProvider = new DataProvider((r1, r2) => {
            return r1 !== r2;
        });
        this._layoutProvider = new LayoutProvider(
            (index) => {
                return ViewTypes.FULL;
            },
            (type, dim) => {
                dim.width = screenWidth;
                dim.height = 200;
            }
        );


        this.state = {
            pagenum: 1,
            infoList: [],
            loading: false,
            isLoadMore: false,
            dataProvider: dataProvider.cloneWithRows([])
        };
    }
    getInfo = () => {
        fetch("https://ghibliapi.herokuapp.com/films"
        ).then((res) => res.json())
            .then((res) => {
                if (res) {
                    this.setState({
                        infoList: res
                    });
                }
            });
    };
    _rowRenderer = (index, data) => {
        // console.log("👘：", index, data.title)
        return (<CellContainer {...data} navigation={this.props.navigation} />);
    };

    _renderFooter = () => {
        return (
            <View>
                <Text>上拉加载更多</Text>
            </View>
        );
    };
    _onLoadMore = () => {
        // Alert.alert(JSON.stringify("num"));
        if (!this.state.isLoadMore) {
            return;
        }
        let num = this.state.pagenum;
        num = num + 1;
        this.setState(
            {
                pagenum: num
            },
            () => {
                // Alert.alert(JSON.stringify(num));
                this.getInfo();
            }
        );
    };
    componentDidMount = () => {
        this.getInfo();
    };
    render() {
        const { infoList } = this.state;
        return (
            <View style={{ flex: 1, minHeight: 1, minWidth: 1 }}>
                <RecyclerListView
                    layoutProvider={this._layoutProvider}
                    dataProvider={this.state.dataProvider.cloneWithRows(infoList)}
                    rowRenderer={this._rowRenderer}
                    extendedState={this.state}
                    onEndReached={this._onLoadMore}
                    onEndReachedThreshold={50}
                    // renderFooter={this._renderFooter}
                    scrollViewProps={{
                        refreshControl: (
                            <RefreshControl
                                refreshing={this.state.loading}
                                onRefresh={async () => {
                                    this.setState({ loading: true });
                                    // analytics.logEvent("Event_Stagg_pull_to_refresh");
                                    await this.getInfo();
                                    this.setState({ loading: false });
                                }}
                            />
                        )
                    }}
                />
            </View>
        );
    }
}

export default FilmList;

