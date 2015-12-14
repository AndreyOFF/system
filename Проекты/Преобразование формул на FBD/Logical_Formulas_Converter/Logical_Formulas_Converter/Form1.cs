using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Globalization;
using System.IO;

namespace Logical_Formulas_Converter
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.Title = "Выберите входной файл с логическими формулами";
            openFileDialog1.Filter = "Text Files(*.txt)|*.txt";
            openFileDialog1.FilterIndex = 0;
            openFileDialog1.FileName = "";
            openFileDialog1.AddExtension = true;

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
                textBox1.Text = openFileDialog1.FileName;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            saveFileDialog1.Title = "Выберите выходной файл для функциональных формул";
            saveFileDialog1.Filter = "Text Files(*.txt)|*.txt";
            saveFileDialog1.FilterIndex = 0;
            saveFileDialog1.FileName = "";
            saveFileDialog1.AddExtension = true;

            if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                textBox2.Text = saveFileDialog1.FileName;
        }

        public class Node
        {
            public string symbol;                           // и(*), или(+)
            public bool not;                                // не(^)
            public Node left, right;
        }

        public class Tree
        {
            public Node root;
            public string value;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string[] message = File.ReadAllLines(textBox1.Text, Encoding.Default);
            string[] message2 = new string[message.Count()];

            for (int i = 0; i < message.Count(); i++)
            {
                message[i] = message[i].Trim().Replace(" ", string.Empty);

                string output = new string(message[i].Take(message[i].IndexOf('=')).ToArray());
                message[i] = new string(message[i].Skip(message[i].IndexOf('=') + 1).ToArray());

                Tree tree = new Tree();
                tree.root = new Node();
                tree.value = output;

                view = "";
                buildTree(message[i], tree.root, brackets(message[i]), false);
                drawTree(tree.root);

                message2[i] = (tree.value.ToString() + " =" + view.ToString());
            }

            File.WriteAllLines(textBox2.Text, message2, Encoding.Default);
            MessageBox.Show("Программа выполнена успешно!");
        }

        public SortedList<int, int> brackets(string str)
        {
            // индексы всех открывающихся скобок / закрывающихся скобок
            List<int> input = new List<int>();
            List<int> output = new List<int>();
            for (int i = 0; i < str.Count(); i++)
            {
                if (str[i] == '(') input.Add(i);
                if (str[i] == ')') output.Add(i);
            }

            // сопоставление каждой открывающейся скобки и закрывающейся скобки
            SortedList<int, int> list = new SortedList<int, int>();
            for (int i = 0; i < output.Count(); i++)
            {
                int max = 0;
                for (int j = 0; j < input.Count(); j++)
                {
                    if (input[j] < output[i] && input[j] > max)
                        max = input[j];
                }

                input.RemoveAt(input.IndexOf(max));
                list.Add(max, output[i]);
            }

            return list;
        }

        public void buildTree(string str, Node node, SortedList<int, int> list, bool not)
        {
            int index1 = str.IndexOfAny(new char[] { '+', '*' });
            int index2 = str.IndexOfAny(new char[] { '(' });

            string left = "", right = "", value = "";
            bool leftNot = false, rightNot = false;

            if (index1 >= 0 && index2 >= 0 && index2 < index1)      // если первые скобки в левой части
            {
                if (index2 - 1 >= 0 && str[index2 - 1] == '^') leftNot = true;
                int last = list.Values[list.IndexOfKey(index2)];
                left = str.Substring(index2 + 1, (last - index2) - 1);
                right = new string(str.Skip(last + 2).ToArray());
                if (last + 1 >= 0 && last + 1 < str.Count()) value = str[last + 1].ToString();

                int index = last + 2;                               // удаляем вторые скобки в правой части при их наличии
                if (index >= 0 && index < str.Count() && str[index] == '^') { index = last + 3; rightNot = true; }
                if (list.IndexOfKey(index) >= 0 && list.IndexOfKey(index) < list.Count())
                {
                    last = list.Values[list.IndexOfKey(index)];
                    if (last >= 0 && last == str.Count() - 1)
                    {
                        if (rightNot == false) right = right.Substring(1, right.Count() - 2);
                        else right = right.Substring(2, right.Count() - 3);
                    }
                }
                else if (right.IndexOfAny(new char[] { '+', '*' }) == -1)   // удаляем ^ перед вторым числом при его наличии
                {
                    if (index >= 0 && index < str.Count())
                    {
                        index = last + 2;
                        if (str[index] == '^') { rightNot = true; right = right.Substring(1, right.Count() - 1); }
                    }
                }
                else rightNot = false;
            }
            else                                                    // если первое число в левой части
            {
                if (str[0] != '^') left = new string(str.Take(index1).ToArray());
                else if (index1 - 1 >= 0 && index1 - 1 < str.Count())
                { left = new string(str.Substring(1, index1 - 1).ToArray()); leftNot = true; }
                right = new string(str.Skip(index1 + 1).ToArray());
                if (index1 >= 0 && index1 < str.Count()) value = str[index1].ToString();

                int index = index1 + 1;                             // удаляем вторые скобки в правой части при их наличии
                if (index >= 0 && index < str.Count() && str[index] == '^') { index = index1 + 2; rightNot = true; }
                if (list.IndexOfKey(index) >= 0 && list.IndexOfKey(index) < list.Count())
                {
                    int last = list.Values[list.IndexOfKey(index)];
                    if (last >= 0 && last == str.Count() - 1)
                    {
                        if (rightNot == false) right = right.Substring(1, right.Count() - 2);
                        else right = right.Substring(2, right.Count() - 3);
                    }
                }
                else if (right.IndexOfAny(new char[] { '+', '*' }) == -1)   // удаляем ^ перед вторым числом при его наличии
                {
                    if (index >= 0 && index < str.Count())
                    {
                        index = index1 + 1;
                        if (str[index] == '^') { rightNot = true; right = right.Substring(1, right.Count() - 1); }
                    }
                }
                else rightNot = false;
            }

            node.not = not;
            node.symbol = value;

            if (left.IndexOfAny(new char[] { '+', '*', '(' }) == -1)
            {
                Node leftNode = new Node();
                leftNode.symbol = left;
                leftNode.left = null;
                leftNode.right = null;
                leftNode.not = leftNot;

                leftNot = false;
                node.left = leftNode;
            }

            if (right.IndexOfAny(new char[] { '+', '*', '(' }) == -1)
            {
                Node rightNode = new Node();
                rightNode.symbol = right;
                rightNode.left = null;
                rightNode.right = null;
                rightNode.not = rightNot;

                rightNot = false;
                node.right = rightNode;
            }

            if (left.IndexOfAny(new char[] { '+', '*', '(' }) != -1)
            {
                node.not = leftNot;
                node.left = new Node();
                buildTree(left, node.left, brackets(left), false);
            }

            if (right.IndexOfAny(new char[] { '+', '*', '(' }) != -1)
            {
                node.right = new Node();
                buildTree(right, node.right, brackets(right), rightNot);
            }
        }

        public string view = "";
        public void drawTree(Node node)
        {
            if (node.left == null && node.right == null)
            {
                if (node.not == true) view += " НЕ (" + node.symbol + ")";
                else view += node.symbol;
            }
            if (node.left != null)
            {
                if (node.left.left == null && node.left.right == null)
                    if (node.not == true) view += " НЕ (";       // 2 вариант
                if (node.symbol == "*") view += " И (";
                else if (node.symbol == "+") view += " ИЛИ (";
                if (node.left.left != null || node.left.right != null)
                    if (node.not == true) view += " НЕ (";       // 1 вариант
                drawTree(node.left);
            }
            if (node.right != null)
            {
                if (node.left.left != null || node.left.right != null)
                    if (node.not == true) view += ")";           // 1 вариант
                if (node.symbol == "*") view += ";";
                else if (node.symbol == "+") view += ";";
                drawTree(node.right);
                if (node.symbol == "*") view += ")";
                else if (node.symbol == "+") view += ")";

                if (node.left.left == null && node.left.right == null)
                    if (node.not == true) view += ")";           // 2 вариант
            }
        }

        
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        private void button5_Click(object sender, EventArgs e)
        {
            saveFileDialog2.Title = "Выберите выходной файл на языке FBD";
            saveFileDialog2.Filter = "IsaXml Files(*.isaxml)|*.isaxml";
            saveFileDialog2.FilterIndex = 0;
            saveFileDialog2.FileName = "";
            saveFileDialog2.AddExtension = true;

            if (saveFileDialog2.ShowDialog() == DialogResult.OK && textBox1.Text != "" && textBox2.Text != "")
                textBox3.Text = saveFileDialog2.FileName;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string message = File.ReadAllLines(textBox1.Text, Encoding.Default)[0];
            message = message.Trim().Replace(" ", string.Empty);

            string output = new string(message.Take(message.IndexOf('=')).ToArray());
            message = new string(message.Skip(message.IndexOf('=') + 1).ToArray());

            Tree tree = new Tree();
            tree.root = new Node();
            tree.value = output;

            view = "";
            buildTree(message, tree.root, brackets(message), false);
            drawTree(tree.root);

            // запись в файл схемы блоков (foreach tree = для каждой строки формул)
            functionWriteFile(tree);

            MessageBox.Show("Программа выполнена успешно!");
        }

        public int count_vars = 0, count_box = 0;
        public List<string> vars = new List<string>();
        public void findVariable(Node node)
        {
            if (node.left == null && node.right == null) { count_vars++; vars.Add(node.symbol); }
            if (node.left != null || node.right != null)
            {
                count_box++;
                if (node.not == true) count_box++;
                findVariable(node.left);
                findVariable(node.right);
            }
        }

        public int id = 1;
        public int width = 8;
        public int height = 4;

        public List<string> boxs = new List<string>();
        public List<string> variables = new List<string>();
        public List<string> arcs = new List<string>();

        public List<int> buff = new List<int>();
        public int from = 0, to = 0, from_size = 0, to_size = 0;

        public void drawFormula(Node node)
        {
            if (node.left == null && node.right == null)
            {
                if (node.not == true)
                {
                    boxs.Add("@BOX:" + id + ",P=(" + width + "," + (height + 4) + "),S=(24,8),C=(1,1),X=NOT\nT=0");
                    //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                    //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                    //if (from != 0 && to != 0)
                    //{
                    //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + from + "," + (buff[from - 1] - 1) + "),T=(" + to + "," + (buff[to - 1] - 1) + ")\nP=(" +
                    //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                    //    from = 0; to = 0;
                    //}
                    width = width - 40;
                    id++;
                }

                variables.Add("@VAR:" + id + ",P=(" + width + "," + height + "),S=(32,4),C=(1,1),X=" + node.symbol);
                //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                //if (from != 0 && to != 0)
                //{
                //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + from + "," + (buff[from - 1] - 1) + "),T=(" + to + "," + (buff[to - 1] - 1) + ")\nP=(" +
                //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                //    from = 0; to = 0;
                //}
                height = height + 4;
                id++;
            }

            if (node.left != null || node.right != null)
            {
                if (node.not == true)
                {
                    boxs.Add("@BOX:" + id + ",P=(" + width + "," + (height + 4) + "),S=(24,8),C=(1,1),X=NOT\nT=0");
                    //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                    //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                    //if (from != 0 && to != 0)
                    //{
                    //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + from + "," + (buff[from - 1] - 1) + "),T=(" + to + "," + (buff[to - 1] - 1) + ")\nP=(" +
                    //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                    //    from = 0; to = 0;
                    //}
                    width = width - 40;
                    id++;
                }

                if (node.symbol == "*")
                {
                    boxs.Add("@BOX:" + id + ",P=(" + width + "," + (height + 2) + "),S=(24,12),C=(2,1),X=AND\nT=0");
                    //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                    //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                    //if (from != 0 && to != 0)
                    //{
                    //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + from + "," + (buff[from - 1] - 1) + "),T=(" + to + "," + (buff[to - 1] - 1) + ")\nP=(" +
                    //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                    //    from = 0; to = 0;
                    //}
                }
                else if (node.symbol == "+")
                {
                    boxs.Add("@BOX:" + id + ",P=(" + width + "," + (height + 2) + "),S=(24,12),C=(2,1),X=OR\nT=0");
                    //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                    //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                    //if (from != 0 && to != 0)
                    //{
                    //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + from + "," + (buff[from - 1] - 1) + "),T=(" + to + "," + (buff[to - 1] - 1) + ")\nP=(" +
                    //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                    //    from = 0; to = 0;
                    //}
                }

                width = width - 40;
                id++;

                drawFormula(node.left);
                drawFormula(node.right);
            }
        }

        public void functionWriteFile(Tree tree)
        {
            List<string> str = new List<string>();
            List<string> str_out = new List<string>();
            str.AddRange(File.ReadAllLines(textBox3.Text, Encoding.Default));

            for (int i = 0; i < str.Count(); i++)
            {
                if (str[i].IndexOf("</LocalVars>") != -1)
                {
                    str_out.Add("  <LocalVars>");
                    findVariable(tree.root);
                    vars.Add(tree.value);

                    if (vars.Count > 0)
                        vars = new List<string>(vars.Distinct());

                    for (int j = 0; j < vars.Count(); j++)
                    {
                        if (vars[j] == tree.value)
                            str_out.Add("    <Variable Name=\"" + tree.value + "\" DataType=\"BOOL\" InitialValue=\"\" Comment=\"\" Address=\"\" Kind=\"VarOutput\" Alias=\"\" AccessRights=\"ReadWrite\" StringSize=\"0\" />");
                        else
                            str_out.Add("    <Variable Name=\"" + vars[j] + "\" DataType=\"BOOL\" InitialValue=\"\" Comment=\"\" Address=\"\" Kind=\"VarInput\" Alias=\"\" AccessRights=\"ReadWrite\" StringSize=\"0\" />");
                    }
                    str_out.Add("  </LocalVars>");
                }
                else if (str[i].IndexOf("#info= FBD") != -1)
                {
                    str_out.Add("#info= FBD");
                    if (tree.root.not == false) str_out.Add("@@NBID=" + Convert.ToInt32(count_box + count_vars + 1).ToString());
                    else str_out.Add("@@NBID=" + Convert.ToInt32(count_box + count_vars + 2).ToString());

                    // вставляем то, что будет прорисовываться
                    //////////////////////////
                    if (tree.root.not == false) for (int k = 0; k < count_box + count_vars + 1; k++) buff.Add(0);
                    else for (int k = 0; k < count_box + count_vars + 2; k++) buff.Add(0);

                    width = ((count_box + 2) * 40);
                    variables.Add("@VAR:" + id + ",P=(" + width + "," + height + "),S=(32,4),C=(1,1),X=" + tree.value);
                    //if (from != 0 && to == 0) { to = id; to_size = width; buff[id - 1]++; }
                    //if (from == 0) { from = id; from_size = width + 24; buff[id - 1]++; }
                    //if (from != 0 && to != 0)
                    //{
                    //    arcs.Add("@ARC:D=0,Z=(0,0),F=(" + to + "," + (buff[to - 1] - 1) + "),T=(" + from + "," + (buff[from - 1] - 1) + ")\nP=(" +
                    //        (from_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ";" + (to_size + 0.4).ToString("#.#", CultureInfo.GetCultureInfo("en-US")) + ")");
                    //    from = 0; to = 0;
                    //}
                    width = width - 32;
                    id++;
                    /////////////////////////

                    drawFormula(tree.root);

                    for (int j = 0; j < boxs.Count(); j++)
                        str_out.Add(boxs[j]);

                    for (int j = 0; j < variables.Count(); j++)
                        str_out.Add(variables[j]);

                    for (int j = 0; j < arcs.Count(); j++)
                        str_out.Add(arcs[j]);

                    str_out.Add("#end_info");
                    str_out.Add("#info= ID_MAX");
                    if (tree.root.not == false) str_out.Add("NextId=" + Convert.ToInt32(count_box + count_vars + 1).ToString());
                    else str_out.Add("NextId=" + Convert.ToInt32(count_box + count_vars + 2).ToString());
                }
                else str_out.Add(str[i]);
            }

            File.WriteAllLines(textBox3.Text, str_out, Encoding.Default);
        }
    }
}