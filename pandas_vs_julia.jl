using DataFrames
using Statistics
using CSV
using Random
using JSON3
using JSON
using UrlDownload
using HTTP
using Dates

# commands: julia > ] > add "name of package"

# Data Structures

s = [1, 2, 3] # vector
s[1]
df = DataFrame(a=11:13, b=21:23) # DataFrame
Random.seed!(1)
df_random = DataFrame(rand(10, 3), [:a, :b, :c]) # DataFrame with random numbers

# Write/Read

CSV.write("julia_file.csv", df_random)
JSON3.write("julia_file.json", df_random)
df = CSV.read("julia_file.csv", DataFrame)
df_json = JSON.parsefile("julia_file.json")

url = "https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/639388c2cbc2120a14dcf466e85730eb8be498bb/iris.csv"
response = HTTP.get(url)
data = CSV.File(IOBuffer(response.body))
df_url = DataFrame(data)


# df_delim = readdlm("delim_file.txt", ' ', Int)

# Inspect Data

first(df, 6) # first 6 rows
last(df, 6) # last 6 rows
describe(df) # summary statistics
describe(df[!, [:a]]) # summary statistics of column a
mean(df.a) # mean of column a

# Select Data

df[1:3, :] #select first N rows, all columns
df[[1, 2, 3], :] # select rows by index
df[:, [:a, :b]] # select columns by name(copy)
df[!, [:A]] # select columns by name(no copy) reference
df[1:3, [:b, :a]]# select subset of rows and columns
df[[3, 1], [:c]] #reverse selection
findall(ismissing, df[:, "a"]) #select Nan Values
filter(!ismissing, df[:, "a"]) #select non Nan Values

# Add Rows/Columns

df[!, "d"] = df[!, "a"] * 100 # add new column based on other column
df[!, "e"] .= false # add new col single Values
push!(df, [0, 0, 0]) #add new row at the end of DataFrame
append!(df, df2) # add rows from DataFrame to existing DataFrame

# Drop Data

filter!(e -> e ≠ 1, a) # drop values form series by index(row axis)
filter!(e -> e ∉ [1, 2], a) # drop values form series by index(row axis)
dropmissing!(df[:, ["b"]]) # drop col by name 
dropmissing!(df) # drop rows with missing values
df[all.(!ismissing, eachrow(df)), :] # drop all rows that contain  null values
df[:, all.(!ismissing, eachcol(df))] # drop all cols that contain null values

# Sort values/index

sort([3, 1, 2]) # sort values
sort([3, 1, 2], rev=true) # sort values in reverse order
sort(df, [:a]) # sort DataFrame by column a
sort(df, [order(:a, rev=true), :b]) # sort DataFrame by column a in reverse order and then by column b

# Filter

mapcols(x -> any(ismissing, x), df) # find cols with na
filter(row - row.a > 100, df) # Values greater than x
filter(row -> row.a == 'a' && row.b >= 5, df) # filter multiple conditions 
df[(df.a.=="test"), :] # filter by string values
df[(df.a.=="test")&(df.b.=="a2"), :] # combine conditions

#Group by

groupby(df, [:a]) # group by column a
gdf = groupby(df, [:a, :b]) #group multiple cols
combine(gdf, :c => sum) # sum third
combine(groupby(df, [:x1]), nrow => :count) # group by and count

# Convert

replace(df.a, missing => 0) # replace missing values with 0
ifelse.(df .== "..", missing, df) # convert .. to Nan
df[!, :a] = parse.(Int64, df[!, :a]) # convert string to Int
df.Date = Date.(df.Date, "dd-mm-yyyy") # convert string to Date

