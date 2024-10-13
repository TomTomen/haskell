import Data.Maybe (mapMaybe)

-- Функция для парсинга генов и ридов из строки данных
parseGenesAndReads :: String -> ([[Int]], [[[Int]]])
parseGenesAndReads dataStr = (genes, reads)
  where
    -- Разбиваем строку на строки по переводу строки
    lines = Prelude.lines dataStr
    -- Парсим количество генов и ридов из первой строки
    (geneCount:readCount:_) = map read $ words (head lines)
    geneLines = take geneCount (tail lines)
    readLines = take readCount (drop (geneCount + 1) lines)

    -- Парсинг генов
    genes = map parseGene geneLines

    -- Парсинг ридов
    reads = map parseRead readLines

    -- Вспомогательная функция для парсинга одного гена
    parseGene :: String -> [Int]
    parseGene line = intervals
      where
        intervals = map read (words line) -- Разделяем по пробелам

    -- Вспомогательная функция для парсинга одного рида
    parseRead :: String -> [[Int]]
    parseRead line = pairs
      where
        intervals = map read (words line) -- Разделяем по пробелам
        pairs = chunksOf 2 intervals

    -- Вспомогательная функция для разбиения списка на пары
    chunksOf :: Int -> [a] -> [[a]]
    chunksOf _ [] = []
    chunksOf n xs = take n xs : chunksOf n (drop n xs)

-- Входные данные
dataStr = "10 10\n120 421 513 571 701 794 805 1068 1117 1254 1276 1307 1600 1682 1769 1794 1817 1857 1866 2334 2455 2470 2480 2623 2636 2902 3008 3114 3131 3202 3238 3253 3369 3534 3591 3618 3673 3675 3788 4227 4364 4824 4876 4969 4987 5032 5292 5397 5446 5547 5602 5666 5685 5882 6041 6280 6390 6404 6414 6803 6837 6943 6999 7024 7051 7263 7442 7538 7549 7771 7773 8055 8181 8207 8208 8245 8291 8334 8539 8545 8546 8683 8868 9230 9276 9322 9411 9550 9572 9645 9865 9915\n143 371 746 788 870 1208 1442 1589 1727 1866 1971 2147 3002 3031 3094 3440 3680 4512 4711 5458 5717 6503 6564 6767 6790 7365 7821 8053 8949 9390 9469 9517\n98 3691 3985 4169 4879 5127 5192 6099 8637 8785\n737 2335 3835 4544 4654 5457 5891 6309 6603 6651 6836 8058 8116 8704 8894 9309 9861 9997\n705 1934 1971 2080 4026 5721 6177 6189 7380 7383 7517 8794\n73 3527 6243 6964 7635 8274 8538 8810\n1876 2049 3084 3758 4319 5813 6961 7791 8382 8724 9179 9579\n345 5061 5423 5827 8142 8555 9604 9758\n2968 5158 5660 7404 8670 9469\n6181 8535\n9552 9553 9555 9555 9556 9556 9559 9560 9561 9561 9562 9562 9563 9565 9566 9567 9568 9568 9570 9570 9571 9571\n9661 9665 9668 9681 9717 9788 9793 9795 9830 9831 9842 9842 9849 9854\n9588 9588 9590 9591 9592 9594 9595 9597 9598 9600 9603 9603\n8811 8817 8818 8823 8827 8828 8830 8831 8834 8835 8837 8837 8842 8845 8846 8857 8858 8858 8859 8862\n9776 9783 9784 9816 9819 9827 9836 9851 9859 9860 146213418 167254205 239563225 246353873 281878322 627857631 687134626 757012332 865087863 883684489 909280790 922765300 960253362 966649454\n9552 9552 9553 9553 9562 9563 9564 9565 9566 9569 9570 9570 9571 9571\n8815 8823 8824 8825 8826 8828 8834 8838 8839 8839 8848 8852 8853 8854 8857 8858 8859 8862 8863 8863 8864 8865\n9778 9791 9793 9814 9817 9826 9830 9836 9838 9853 9855 9857 9859 9861 9862 243833948 524762733 546818852 825288367 829041647 868702120 905796140 936597089 972823142\n9593 9600 9602 9603\n9652 9695 9698 9722 9747 9751 9755 9771 9777 9797 9813 9820 9839 9854"

-- Запуск парсинга и вывод результатов
main :: IO ()
main = do
    let (genes, reads) = parseGenesAndReads dataStr
    putStrLn "Гены:"
    print genes
    putStrLn "Риды:"
    print reads