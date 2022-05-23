import React, { PureComponent } from 'react'
import {
    FlatList,
    TouchableOpacity,
    Dimensions,
    StyleSheet,
    Image,
    Text,
    View,
    Animated,
    Easing,
    ImageBackground,
} from 'react-native'
import request from './../RequestAPI';
// import Toast, {DURATION} from 'react-native-easy-toast'

const { width: screenWidth, height: screenHeight } = Dimensions.get('window');

export default class ColumnList extends PureComponent {

    constructor(props) {
        super(props);

        this.state = {
            sourceData: [],
            refreshing: false,
            flatHeight: 0,
            indexText: '',
        }
    }

    //改变value而不需要重新re-render的变量，声明在construct外面
    currPage = 0;

    // 加载数据
    _getNewsList = () => {
        let _this = this;
        let requestCode = this.props.requestCode;


        fetch("https://ghibliapi.herokuapp.com/films"
        ).then((res) => res.json())
            .then((res) => {
                if (res) {
                    console.log('🍌', res)
                    this.setState({
                        sourceData: res
                    });
                }
            }).catch((err) => {
                console.log(err);
            });

        // request({
        //     url: `https://c.3g.163.com/nc/video/home/0-10.html`,
        //     method: 'GET',
        //     success: (data) => {
        //         _this.setState({
        //             sourceData: _this.state.refreshing ? data[requestCode] : [..._this.state.sourceData, ...data[requestCode]]
        //         });
        //         _this.currPage += 10;
        //     },
        //     error: (err) => {
        //         alert('网络异常');
        //         // _this.refs.toast.show('网络请求异常');
        //     },
        //     complete: () => {
        //         _this.state.refreshing && _this.setState({ refreshing: false });
        //     }
        // });
    }

    //Header视图
    /**
     * _renderHeader = () => {

    }
     */

    //Footer视图
    _renderFooter = () => {
        let len = this.state.sourceData.length;
        return (
            <View style={{ flexDirection: 'row', justifyContent: 'center', alignItems: 'center', height: len < 1 ? 0 : 40 }}>
                <Image source={require("./../../assets/images/i_loading.gif")} resizeMode={'contain'} style={{ width: 20, height: 20, marginRight: 5, height: len < 1 ? 0 : 40 }} />
                <Text style={{ color: '#515151' }}>正在加载...</Text>
            </View>
        )
    }

    //分割线
    _renderItemSeparatorComponent = ({ highlighted }) => {
        return (
            <View style={{ height: 1, backgroundColor: '#e6e6e6' }}></View>
        )
    }

    //没有数据时候页面显示
    _renderEmptyView = () => {
        return (
            <View style={{ height: this.state.flatHeight, backgroundColor: '#f8f8f8', justifyContent: 'center', alignItems: 'center', marginTop: 20 }}>
                <Image source={require("./../../assets/images/list_placeholder.png")} resizeMode={'contain'} style={{ width: 80, height: 60 }} />
            </View>
        )
    }

    //设置item高度
    _setFlatListHeight = (e) => {
        let height = e.nativeEvent.layout.height;
        if (this.state.flatHeight < height) {
            this.setState({ flatHeight: height })
        }
    }

    /**
     * 此函数用于为给定的item生成一个不重复的key
     * key的作用是使React能够区分同类元素的不同个体，以便在刷新的时候能确定其变化的位置，减少重复渲染的开销
     * 若不指定此函数，则默认抽取item.key作为key值，若key.item不存在，则使用数组下标
     */
    _keyExtractor = (item, index) => index + '';

    //上拉加载更多
    _onEndReached = () => {
        this._getNewsList();
    }

    //下拉刷新
    _renderRefresh = () => {
        this.setState({ refreshing: true }); //开始刷新
        this.currPage = 0;
        this._getNewsList();
    }

    _renderItem = ({ item }) => {
        return (<ColumnList
            item={item}
            onPressItem={this._onPressItem}
            selected={this.state.selected === item.id}
        />
        );
    }

    _onPressItem = (item) => {

        this.setState({
            selected: item.id
        })

        if (item['videoinfo']) {
            this.props.navigation.push('VideoDetail', { item })
            return
        }

        this.props.navigation.push('NewsDetail', { item })
    }

    //组件渲染后开始加载数据
    componentDidMount() {
        this._getNewsList()
    }

    render() {
        return (
            <View style={styles.container}>
                <FlatList
                    ref={ref => this.flatList = ref}
                    data={this.state.sourceData}
                    extraData={this.state.selected}
                    keyExtractor={this._keyExtractor}
                    renderItem={this._renderItem}
                    //初始加载的条数，不会被卸载
                    initialNumToRender={10}
                    //决定当距离内容最底部还有多远时候触发onEndReached回调，数值范围：0~1。例如：0.5表示可见布局的最底端距离content最底端等于可见布局一半高度的时候调用该回调
                    onEndReachedThreshold={0.5}
                    //当列表被滚动到距离内容最底部不足onEndReacchedThreshold设置的距离时调用此函数
                    onEndReached={this._onEndReached}
                    //ListHeaderComponent={this._renderHeader}
                    ListFooterComponent={this._renderFooter}
                    ItemSeparatorComponent={this._renderItemSeparatorComponent}
                    ListEmptyComponent={this._renderEmptyView}
                    onLayout={this._setFlatListHeight}
                    //正在加载的时候设置为true，会在界面上显示一个正在加载的提示
                    refreshing={this.state.refreshing}
                    //如果设置了此选项，则会在列表头部添加一个标准的RefreshControl控件，以便实现“下拉刷新”的功能。同时你需要正确设置refreshing属性。
                    onRefresh={this._renderRefresh}
                />
                {/* <Toast
                    ref='toast'
                    style={{ backgroundColor: 'black' }}
                    position='center'
                    opacity={0.8}
                    textStyle={{ color: 'white' }}
                /> */}
            </View>
        )
    }

}

class ColumnListItem extends React.PureComponent {

    _onPress = () => {
        this.props.onPressItem(this.props.item)
    }

    render() {
        let item = this.props.item
        //判断是否是三图布局
        let isThreePic = item['imgnewextra']
        //判断是否是视频布局
        let isVideo = item['videoinfo']

        if (isThreePic) {
            return (
                <TouchableOpacity
                    {...this.props}
                    onPress={this._onPress}
                    style={styles.picItem}
                    activeOpacity={0.8}
                >
                    <View style={{ justifyContent: 'space-between' }}>
                        <Text style={{ fontSize: 16, lineHeight: 25, color: '#2c2c2c' }}>{item.title}</Text>

                        <View style={{ flexDirection: 'row', marginVertical: 5, justifyContent: 'space-between' }}>
                            <Image source={{ uri: item.imgsrc }} style={{ width: screenWidth * 0.35, height: 80 }} />
                            {
                                item.imgnewextra.map((imgItem, index) => (
                                    <Image source={{ uri: imgItem.imgsrc }} key={index + ''} style={{ width: screenWidth * .3, height: 80 }} />
                                ))
                            }
                        </View>

                        <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' }}>
                            <View style={{ flexDirection: 'row' }}>
                                <Text style={{ marginRight: 6 }}>{item.source}</Text>
                                <Text style={{ marginRight: 6 }}>{item.replyCount}跟帖</Text>
                            </View>

                            {/*这里应该有个X号*/}
                        </View>
                    </View>
                </TouchableOpacity>
            )
        }

        if (isVideo) {
            return (
                <TouchableOpacity
                    {...this.props}
                    onPress={this._onPress}
                    style={styles.picItem}
                    activeOpacity={0.8}
                >
                    <View style={{ justifyContent: 'space-between' }}>
                        <Text style={{ fontSize: 16, lineHeight: 25, color: '#2c2c2c' }}>{item.title}</Text>

                        <ImageBackground source={{ uri: item.imgsrc }} resizeMode={'cover'} style={{ height: 180, marginVertical: 6, justifyContent: 'center', alignItems: 'center' }}>
                            <View style={{ width: 50, height: 50, borderRadius: 25, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', alignItems: 'center' }}>
                                <Image source={require('./../../assets/images/i_play.png')} resizeMode={'contain'} style={{ width: 18, height: 18, marginLeft: 3 }} />
                            </View>
                        </ImageBackground>

                        <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' }}>
                            <View style={{ flexDirection: 'row' }}>
                                <Text style={{ marginRight: 6 }}>{item.source}</Text>
                                <Text style={{ marginRight: 6 }}>{item.replyCount}跟帖</Text>
                            </View>

                            {/*这里应该有个X号*/}
                        </View>
                    </View>
                </TouchableOpacity>
            )
        }

        return (
            <TouchableOpacity
                {...this.props}
                onPress={this._onPress}
                style={styles.item}
                activeOpacity={0.8}
            >
                <View style={{ width: screenWidth * 0.63, height: 80, justifyContent: 'space-between' }} >
                    <Text style={{ fontSize: 16, lineHeight: 25, color: '#2c2c2c' }}>{item.title}</Text>

                    <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' }}>
                        <View style={{ flexDirection: 'row' }}>
                            <Text style={{ marginRight: 6 }}>{item.source}</Text>
                            <Text style={{ marginRight: 6 }}>{item.replyCount}跟帖</Text>
                        </View>

                        {/*这里应该有个X号*/}
                    </View>
                </View>

                <Image source={{ uri: item.imgsrc }} style={{ width: screenWidth * 0.3, height: 80 }} />
            </TouchableOpacity>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F8F8F8',
    },
    item: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        padding: 7,
    },
    picItem: {
        padding: 7,
    }
})