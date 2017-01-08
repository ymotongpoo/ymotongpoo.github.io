[string]$theme = "tropic"
[string]$date = (Get-Date -Format "yyyyMMddHHmmss")
[string]$tmp = (Join-Path ($env:TEMP) ${date})

function Deploy($comments) {
    Write-Output "Build and deploy to GitHub"
    [string]$commentStr = ""
    $comments | ForEach-Object { $commentStr += $_ }

    # build
    Get-ChildItem -Recurse public | Remove-Item -Force -ErrorAction SilentlyContinue -Confirm:$false
    hugo --theme=${theme}

    # git add, commit and push to source
    git add --all
    git commit -m "[source] ${date} : ${commentStr}"
    git push origin source:source

    # git add, commit and push to master
    New-Item -Path ${tmp} -ItemType Directory
    Copy-Item -Recurse public ${tmp}
    Get-ChildItem -Recurse public | Remove-Item -Force -ErrorAction SilentlyContinue -Confirm:$false
    git checkout master
    Copy-Item -Recurse -Force ${tmp}/. .
    git add --all
    git commit -m "[site] ${date} : $commentStr"
    git push origin master:master
    git checkout source
}

function Serve {
    Set-Item env:HUGO_ENV -Value "DEV"
    hugo server --theme="${theme}" --watch --buildDrafts=true --buildFuture=true
}

function New($category, $comments) {
    [string]$prefix = (Get-Date -Format "yyyy-MM-dd")
    [string]$slug = ""
    foreach ($token in $comments) {
        $slug += "-" + ${token};
    }
    [string]$filename = Join-Path ${category} "${prefix}${slug}.md"
    hugo new ${filename}
}

function Usage {
    Write-Output "./build.ps1 [deploy <commmit message>] [serve] [diary <slugs>] [tech <slugs>]"
}

switch ($args[0]) {
    "deploy" {
        $args = $args[1..$args.Length]
        Deploy $args
        break
    }
    "diary" {
        $args = $args[1..$args.Length]
        New "diary" $args
        break
    }
    "tech" {
        $args = $args[1..$args.Length]
        New "tech" $args
        break
    }
    "serve" {
        Serve
        break
    }
    Default {
        echo "foo"
        break       
    }
}