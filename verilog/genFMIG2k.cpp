#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>
using namespace std;

int main()
{
    srand(time(0));
    int min = -128;
    int max = 127;
    vector<int> vec; // all kinds of numbers of input to simulate
    vec.push_back(2);
    vec.push_back(3);
    vec.push_back(4);
    vec.push_back(6);
    vec.push_back(7);
    vec.push_back(255);
    vec.push_back(256);
    for (unsigned int k = 0; k < vec.size(); ++k)
    {
        char buffer[5];
        itoa(vec[k], buffer, 10);
        string filename = string("./FMIG2k/FMIG") + buffer + ".txt";
        cerr << "Generating data of " << vec[k] << " inputs with filename: " << filename << endl;
        fstream fout(filename.c_str(), fstream::out);
        for (int i = 0; i < 100; ++i)
        {
            int minn = 2147483647;
            int idxx;
            for (int j = vec[k] - 1; j >= 0; --j)
            {
                int gen = (rand() % 256 - 128);
                if (gen < minn)
                {
                    minn = gen;
                    idxx = j;
                }
                fout << gen << " ";
            }
            fout << minn << " " << idxx << endl;
        }
        fout.close();
    }
    return 0;
}