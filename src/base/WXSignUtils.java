package base;

import java.math.BigDecimal;
import java.util.*;

/**
 * 微信支付签名
 * @author gonglixun
 * @date 2016年10月25日下午4:47:07
 */
public class WXSignUtils {

    /**
     * 微信支付签名算法sign
     * @param characterEncoding
     * @param parameters
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static String createSign(String characterEncoding,SortedMap<Object,Object> parameters){


        StringBuffer sb = new StringBuffer();
        Set es = parameters.entrySet();//所有参与传参的参数按照accsii排序（升序）
        Iterator it = es.iterator();
        while(it.hasNext()) {
            Map.Entry entry = (Map.Entry)it.next();
            String k = (String)entry.getKey();
            Object v = entry.getValue();
            if(null != v && !"".equals(v)
                    && !"sign".equals(k) && !"key".equals(k)) {
                sb.append(k + "=" + v + "&");
            }
        }
        sb.append("key=" + "GLX19894270GLZ19894270GLX1989427");
        System.out.println("字符串拼接后是："+sb.toString());
        String sign = MD5Util.MD5Encode(sb.toString(),characterEncoding).toUpperCase();
        return sign;
    }



    public static void main(String[] args) {
        SortedMap<Object, Object> map = new TreeMap<Object, Object>();
        map.put("a","123");
        String sign = createSign("utf-8",map);
        System.out.println(sign);
    }
}