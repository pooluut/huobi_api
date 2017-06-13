library(rjson)

python_install_path = 'python3'
python_script_path = './huobi_io.py'
DEBUG=TRUE


get_market_kline <- function(period='1min', symbol='ethcny',long_pooling='false')
{
    para_frame <- data.frame(
        period=period,
        symbol=symbol,
        long_pooling=long_pooling
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_market_kline','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}





get_market_depth <- function(type='step0', symbol='ethcny',long_pooling='false')
{
    para_frame <- data.frame(
        type=type,
        symbol=symbol,
        long_pooling=long_pooling
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_market_depth','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}






get_market_trade <- function(symbol='ethcny',long_pooling='false')
{
    para_frame <- data.frame(
        symbol=symbol,
        long_pooling=long_pooling
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_market_trade','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}






get_market_detail <- function(symbol='ethcny',long_pooling='false')
{
    para_frame <- data.frame(
        symbol=symbol,
        long_pooling=long_pooling
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_market_detail','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}






get_timestamp <- function()
{
    allargs=c(python_script_path,'get_timestamp')
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}





get_balance <- function()
{
    allargs=c(python_script_path,'get_balance')
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}



get_order_info <-function(order_id)
{
    para_frame <- data.frame(
        order_id=order_id
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_order_info','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}



post_orders <- function(type, amount, price='3000000', symbol='ethcny')
{
    para_frame <- data.frame(
        symbol=symbol,
        type=type,
        amount=amount,
        price=price
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'post_orders','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(output)
}



post_cancel_order <- function(order_id)
{
    para_frame <- data.frame(
        order_id=order_id
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'post_cancel_order','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(output)
}



get_order_matchresult <-function(order_id)
{
    para_frame <- data.frame(
        order_id=order_id
        );
    json_str <- paste('\'',toJSON(para_frame),'\'')
    allargs=c(python_script_path,'get_order_matchresult','-s',json_str)
    if (DEBUG)
        cat(python_install_path,allargs,'\n')
    output = system2(python_install_path,args=allargs,stdout=TRUE)
    return(fromJSON(output))
}


# get_orders <- function()
# {
#     allargs=c(python_script_path,'get_orders')
#     if (DEBUG)
#         cat(python_install_path,allargs,'\n')
#     output = system2(python_install_path,args=allargs,stdout=TRUE)
#     print(output)
#     return(fromJSON(output))
# }



